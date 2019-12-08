//
//  GrowAnimator.swift
//  dog-naming
//
//  Created by Joacim Nidén on 2018-08-16.
//  Copyright © 2018 Joacim Nidén. All rights reserved.
//

import UIKit

open class GrowAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    var presenting = true
    let duration = 0.2
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let toVc = transitionContext.viewController(forKey: .to),
            let fromVC = presenting ? toVc : transitionContext.viewController(forKey: .from),
            let fromView = fromVC.view
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let initialFrame = presenting ? originFrame : fromView.frame
        let finalFrame = presenting ? fromView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            fromView.transform = scaleTransform
            fromView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            fromView.clipsToBounds = true
            containerView.insertSubview(toVc.view, belowSubview: fromView)
        }
            
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            let transform: CGAffineTransform = self.presenting ? .identity : scaleTransform
            fromView.transform = transform
            fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
