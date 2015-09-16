//
//  ViewController.swift
//  Test
//
//  Created by Aryan on 9/16/15.
//  Copyright (c) 2015 Couchsurfing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewController2: ViewController2?
    var lastPanDetected = CGPointZero

    @IBAction func buttonSelected(sender: AnyObject) {
        showViewController2(true)
    }
    
    func showViewController2(show: Bool) {
        if viewController2 == nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            viewController2 = sb.instantiateViewControllerWithIdentifier("ViewController2") as? ViewController2
            viewController2?.view.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, view.frame.size.height)
            view.addSubview(viewController2!.view)
            
            let panRecognizer = UIPanGestureRecognizer(target: self, action: "panDetected:")
            viewController2?.view.addGestureRecognizer(panRecognizer)
        }
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
            var frame = self.view.frame
            frame.origin.y = show ? 0 : self.view.frame.size.height
            self.viewController2?.view.frame = frame
        }, completion: nil)
    }

    func panDetected(pan: UIPanGestureRecognizer) {
        let translation = pan.translationInView(view)
        let verticalMovement: CGFloat = translation.y - lastPanDetected.y
        
        switch pan.state {
        case .Changed:
            var frame = viewController2!.view.frame
            frame.origin.y = verticalMovement
            viewController2!.view.frame = frame
            
        case .Ended:
            showViewController2(false)
            
        default:
            break
        }
        
    }

}

