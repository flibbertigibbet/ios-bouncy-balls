//
//  ViewController.swift
//  Quadrilate
//
//  Created by Kathryn Killebrew on 11/6/15.
//  Copyright © 2015 Kathryn Killebrew. All rights reserved.
//

import UIKit
import CoreMotion

class QuadriController: UIViewController {
    
    var circles: [UIView] = []
    
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let ballBehavior = UIDynamicItemBehavior()
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {[unowned self] (data, error) in
                if let d = data {
                    self.gravity.gravityDirection = CGVector(dx: CGFloat(d.gravity.x), dy: CGFloat(-d.gravity.y))
                }
            }
        }

        animator = UIDynamicAnimator(referenceView: view)
        
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        ballBehavior.elasticity = 0.7
        ballBehavior.density = 3
        ballBehavior.friction = 0.1
        ballBehavior.resistance = 0.1
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
        animator?.addBehavior(ballBehavior)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        manager.stopDeviceMotionUpdates()
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print("tapped (\(location.x), \(location.y))")
        addCircleAt(location: location)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        clearCircles()
    }
    
    func addCircleAt(location: CGPoint) {
        let circleBounds = CGRect(x: location.x - 15, y: location.y - 15, width: 30, height: 30)
        let circle = CircleView(frame: circleBounds)
        circles.append(circle)
        view.addSubview(circle)
        
        gravity.addItem(circle)
        collision.addItem(circle)
        ballBehavior.addItem(circle)
        
        view.setNeedsDisplay()
    }
    
    func clearCircles() {
        for circle in circles {
            gravity.removeItem(circle)
            collision.removeItem(circle)
            ballBehavior.removeItem(circle)
            circle.removeFromSuperview()
        }
        circles = []
        view.setNeedsDisplay()
    }

}
