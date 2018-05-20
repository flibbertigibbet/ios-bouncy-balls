//
//  CircleView.swift
//  Quadrilate
//
//  Created by Kathryn Killebrew on 11/6/15.
//  Copyright © 2015 Kathryn Killebrew. All rights reserved.
//

import UIKit

class CircleView: UIView {
        
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(getRandomColor())
        
        let circle = UIBezierPath(ovalIn: rect)
        circle.fill()
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
    
    func getRandomColor() -> CGColor {
        
        func randomCGFloat() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
        
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1.0).cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
