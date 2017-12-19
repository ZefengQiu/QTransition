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
    
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveLinear,
                   animations: {
                    fromView.alpha = self.isPresenting ? 1 : 0
                    toView.alpha = self.isPresenting ? 0 : 1
    }, completion: { _ in
      fromView.alpha = self.isPresenting ? 0 : 1
      toView.alpha = self.isPresenting ? 1 : 0
    })
  }
  
}
