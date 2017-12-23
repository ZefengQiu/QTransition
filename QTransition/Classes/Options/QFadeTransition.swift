//
//  QFadeTransition.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-12-18.
//

import UIKit

public class QFadeTransition: QBaseTransition {
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    self.isPresenting ? containerView.addSubview(toView) : containerView.addSubview(fromView)
    self.isPresenting ? containerView.bringSubview(toFront: toView) : containerView.bringSubview(toFront: fromView)
    toView.alpha = 0
    
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveLinear,
                   animations: {
                    fromView.alpha = 0
                    toView.alpha = 1
    }, completion: { _ in
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
