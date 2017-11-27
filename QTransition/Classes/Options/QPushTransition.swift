//
//  QPushTransition.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-27.
//

import UIKit

public class QPushTransition: QBaseTransition {
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    self.isPresenting ? containerView.addSubview(toView) : containerView.addSubview(fromView)
    let initialPosX = toView.frame.width
    
    var present = self.isPresenting
    if let op = self.operation {
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
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
