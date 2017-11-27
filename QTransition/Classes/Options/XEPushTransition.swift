//
//  XEPushTransition.swift
//  XELibraryPodsEditor
//
//  Created by Will Qiu on 2017-04-18.
//  Copyright © 2017 XE.com. All rights reserved.
//

import UIKit

public class XEPushTransition: XEBaseTransition
{
    override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView)
    {
        let duration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        self.isPresenting ? containerView.addSubview(toView) : containerView.addSubview(fromView)
        let initialPosX = toView.frame.width
        
        var present = self.isPresenting
        if let op = self.operation
        {
            present = (op == .push)
        }
        
        toView.frame.origin.x = present ? initialPosX : 0
        present ? containerView.bringSubview(toFront: toView) : containerView.bringSubview(toFront: fromView)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        fromView.frame.origin.x = present ? 0 : initialPosX
                        toView.frame.origin.x = 0
        }, completion: { _ in
            if transitionContext.transitionWasCancelled
            {
                transitionContext.completeTransition(false)
            }
            else
            {
                transitionContext.completeTransition(true)
            }
        })
    }
    
}
