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
    if self.isPresenting {
      containerView.addSubview(toView)
    } else {
      containerView.addSubview(fromView)
    }
   
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
