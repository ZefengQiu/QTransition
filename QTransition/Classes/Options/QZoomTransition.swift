//
//  QZoomTransition.swift
//  Pods-QTransition_Example
//
//  Created by Zefeng Qiu on 2017-12-23.
//

import UIKit

public class QZoomTransition: QBaseTransition {
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    self.isPresenting ? containerView.addSubview(toView) : containerView.addSubview(fromView)
    self.isPresenting ? containerView.bringSubview(toFront: toView) : containerView.bringSubview(toFront: fromView)
    
    let transform = CGAffineTransform.identity
    toView.transform = transform.scaledBy(x: 0, y: 0)
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveEaseOut,
                   animations: {
                    toView.transform = CGAffineTransform.identity
    }, completion: { _ in
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
