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
  }
  
}
