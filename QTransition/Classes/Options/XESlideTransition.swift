//
//  XESlideTransition.swift
//  XELibraryPodsEditor
//
//  Created by Will Qiu on 2017-05-30.
//  Copyright © 2017 XE.com. All rights reserved.
//

import UIKit

public class XESlideTransition: XEBaseTransition
{
    public enum Direction
    {
        case left
        case right
        case top
        case bottom
    }
    
    /// properties for menu transition
    public var menuWidth: CGFloat = 0.0
    public var direction: Direction = .left
    
    override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView)
    {
        let duration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let controller = self.isPresenting ? toVC : fromVC
        
        if self.isPresenting
        {
            containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        switch self.direction
        {
            case .left:
                dismissedFrame.origin.x = -presentedFrame.width
            case .right:
                dismissedFrame.origin.x = containerView.frame.size.width
            case .top:
                dismissedFrame.origin.y = -presentedFrame.height
            case .bottom:
                dismissedFrame.origin.y = containerView.frame.size.height
        }
        
        let initalFrame = self.isPresenting ? dismissedFrame : presentedFrame
        let finalFrame = self.isPresenting ? presentedFrame : dismissedFrame
        
        controller.view.frame = initalFrame
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        controller.view.frame = finalFrame
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
