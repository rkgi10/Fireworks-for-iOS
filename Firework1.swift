//
//  Firework1.swift
//  Uberworks
//
//  Created by Rohit Gurnani on 06/11/15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit
import EasyAnimation

class Firework1 {
    var from : CGPoint!
    var to : CGPoint!
    var firstColor : UIColor!
    var secondColor : UIColor!
    var view : UIView!
    var timedelay : NSTimeInterval!
 
    init(from : CGPoint, to : CGPoint, firstColor : UIColor, secondColor : UIColor, view : UIView, timedelay : NSTimeInterval)
    {
        self.from = from
        self.to = to
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.view = view
        self.timedelay = timedelay
    }
    
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }

    
    func animatedLineFrom(from : CGPoint, to : CGPoint)-> CAShapeLayer
    {
        let linePath = UIBezierPath()
        linePath.moveToPoint(from)
        linePath.addLineToPoint(to)
        
        let line = CAShapeLayer()
        line.path = linePath.CGPath
        line.lineCap = kCALineCapButt
        line.strokeColor = self.firstColor.CGColor
        
        line.strokeEnd = 0.0
        UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            line.strokeEnd = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.9, options: [.CurveEaseOut], animations: {
            line.strokeStart = 1.0
            }, completion: nil)
        
        return line
    }
    
    func firework1(at atPoint : CGPoint)->CAReplicatorLayer
    {
        let replicator = CAReplicatorLayer()
        replicator.position = atPoint
        
        let f11linePath = UIBezierPath()
        f11linePath.moveToPoint(CGPoint(x: 0, y: -10))
        f11linePath.addLineToPoint(CGPoint(x: 0, y: -120))
        let f11line = CAShapeLayer()
        f11line.path = f11linePath.CGPath
        f11line.strokeColor = self.firstColor.CGColor
        replicator.addSublayer(f11line)
        
        let f12linePath = UIBezierPath()
        f12linePath.moveToPoint(CGPoint(x: 0, y: -25))
        f12linePath.addLineToPoint(CGPoint(x: 0, y: -120))
        f12linePath.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/20)))
        let f12line = CAShapeLayer()
        f12line.path = f12linePath.CGPath
        f12line.lineDashPattern = [20, 2]
        f12line.strokeColor = self.secondColor.CGColor
        replicator.addSublayer(f12line)
        
        //superpowers of replicator layer
        replicator.instanceCount = 20
        print(M_PI)
        replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)
        
        f11line.strokeEnd = 0.0
        UIView.animateWithDuration(1.2, delay: 0.33, options: [UIViewAnimationOptions.CurveEaseOut], animations: {
            f11line.strokeEnd = 1.0
            }, completion: nil)
        
        f12line.strokeEnd = 0
        UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveEaseOut], animations: {
            f12line.strokeEnd = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: [.CurveEaseIn], animations: {
            //making the lines disappear
            f11line.strokeStart = 1.0
            f12line.strokeStart = 0.5
            
            //rotating the replicator
            f11line.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
            f12line.transform = CATransform3DMakeRotation(CGFloat(M_PI_4/2), 0, 0, 1)
            
            replicator.opacity = 0.0
            }, completion: nil)
        
        
        return replicator
    }
    
    func addFirework1()
    {
        self.view.layer.addSublayer(
            animatedLineFrom(self.from , to: self.to)
        )
        delay(seconds: self.timedelay, completion: {
            self.view.layer.addSublayer(self.firework1(at: self.to))
        })
       // self.view.backgroundColor = UIColor.blueColor()
    }

    
}