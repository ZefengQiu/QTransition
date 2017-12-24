//
//  QZoomSlideTransition.swift
//  Pods-QTransition_Example
//
//  Created by Zefeng Qiu on 2017-12-24.
//

import UIKit

public class QZoomSlideTransition: QBaseTransition {
  
  public var direction: QTransitionConstant.Direction = .left
  public var zoomScale: CGFloat = 0.8
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    let controller = self.isPresenting ? toVC : fromVC
    
    if self.isPresenting {
      containerView.addSubview(controller.view)
    }
    
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    
    switch self.direction {
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
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
    
  }
  
}
