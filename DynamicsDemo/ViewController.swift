//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by NguyenCuong on 1/18/18.
//  Copyright © 2018 NguyenCuong. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    //MARK: dong co vat ly
    var animatior: UIDynamicAnimator!
    //MARK: mo hinh hanh vi cua luc hap dan
    var gravity: UIGravityBehavior!
    //AMRK: set ranh gioi
    var collision: UICollisionBehavior!
    
    var firstContavt = false
    
    
    var square: UIView!
    var snap: UISnapBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: create 1 view
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.gray
        view.addSubview(square)
        //create view
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        
        //xu ly hanh dong di chuyen va luc hap dan
        animatior = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animatior.addBehavior(gravity)
        
        //dinh nghia ranh gioi..
        collision = UICollisionBehavior(items: [square])
//        collision = UICollisionBehavior(items: [square, barrier])
        collision.collisionDelegate = self
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath.init(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animatior.addBehavior(collision)
        
        
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        itemBehaviour.elasticity = 0.6
        animatior.addBehavior(itemBehaviour)

    }
    

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(identifier ?? nil)")
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = UIColor.gray
        }
        
        if !firstContavt {
            firstContavt = true
            
            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
            square.backgroundColor = UIColor.gray
            view.addSubview(square)
            
            
            collision.addItem(square)
            gravity.addItem(square)
            
            let attack = UIAttachmentBehavior(item: collidingView, attachedTo: square)
            animatior.addBehavior(attack)
            
        }
        
    }
    


}

