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
    if self.isPresenting {
      containerView.addSubview(toView)
    } else {
      containerView.addSubview(fromView)
    }
    
    let transform = CGAffineTransform.identity
    if self.isPresenting {
      toView.transform = transform.scaledBy(x: 0, y: 0)
    } else {
      fromView.transform = transform
    }
   
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveEaseOut,
                   animations: {
                    if self.isPresenting {
                      toView.transform = .identity
                    } else {
                      //scaleBy cannot down to zero due to transfrom matrix
                      fromView.transform = transform.scaledBy(x: 0.001, y: 0.001)
                    }
    }, completion: { _ in
      if transitionContext.transitionWasCancelled {
        transitionContext.completeTransition(false)
      }else {
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
