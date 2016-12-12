//
//  CustomAnimation.swift
//  BNRWhackMole
//
//  Created by zhk on 16/6/26.
//  Copyright © 2016年 zhk. All rights reserved.
//

import UIKit

class CustomAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting :Bool
    let duration :NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        
        super.init()
    }
    
    
    // ---- UIViewControllerAnimatedTransitioning methods
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    
    // ---- Helper methods
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)
            else {
                return
        }
        
        // Position the presented view off the top of the container view

        
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        presentedControllerView.alpha = 0

        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            
            presentedControllerView.transform = CGAffineTransformMakeScale(1, 1)
                presentedControllerView.alpha = 1

            }) { (completed: Bool) -> Void in
                transitionContext.completeTransition(completed)

        }
        
        
        
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            else {
                return
        }
        
        // Animate the presented view off the bottom of the view
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            
            presentedControllerView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                presentedControllerView.alpha = 0

            }) { (completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
                
        }
        
    }
}
