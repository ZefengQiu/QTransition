//
//  QPageTransition.swift
//  Pods-QTransition_Example
//
//  Created by Zefeng Qiu on 2018-01-04.
//

import UIKit

public class QPageTransition: QBaseTransition {
  
  public var direction: QTransitionConstant.Options.Page = .left
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    
    if self.isPresenting {
      containerView.addSubview(toVC.view)
    }
    
    let presentedFrame = transitionContext.finalFrame(for: toVC)
    var presentingFrame = presentedFrame
    var dismissFrame = presentedFrame
    
    switch self.direction {
    case .left:
      presentingFrame.origin.x = presentedFrame.width
      dismissFrame.origin.x = -presentedFrame.width
    case .right:
      break
      
    case .top:
      break
      
    case .bottom:
      break
    }
    
    toVC.view.frame = self.isPresenting ? presentingFrame : dismissFrame
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    toVC.view.frame = presentedFrame
                    fromVC.view.frame = self.isPresenting ? dismissFrame : presentingFrame
    }, completion: { _ in
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
