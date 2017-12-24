//
//  QZoomSlideTransition.swift
//  Pods-QTransition_Example
//
//  Created by Zefeng Qiu on 2017-12-24.
//

import UIKit

public class QZoomSlideTransition: QBaseTransition {
  
  public var direction: QTransitionConstant.Options.ZoomSlide = .left
  public var zoomScale: CGFloat = 0.6
  
  override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    let duration = self.transitionDuration(using: transitionContext)
    let containerView = transitionContext.containerView
    let controller = self.isPresenting ? toVC : fromVC
    containerView.addSubview(controller.view)
  
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    
    let transform = CGAffineTransform.identity
    if self.isPresenting {
      toView.transform = transform.scaledBy(x: self.zoomScale, y: self.zoomScale)
    }
    
    switch self.direction {
    case .left:
      dismissedFrame.origin.x = -presentedFrame.width
      dismissedFrame.origin.y = presentedFrame.height * (1 - self.zoomScale) / 2
    case .right:
      dismissedFrame.origin.x = containerView.frame.size.width
      dismissedFrame.origin.y = presentedFrame.height * (1 - self.zoomScale) / 2
    case .top:
      dismissedFrame.origin.y = -presentedFrame.height * self.zoomScale
      dismissedFrame.origin.x = presentedFrame.width * (1 - self.zoomScale) / 2
    case .bottom:
      dismissedFrame.origin.y = containerView.frame.size.height * self.zoomScale
      dismissedFrame.origin.x = presentedFrame.width * (1 - self.zoomScale) / 2
    }
    
    let initalFrame = self.isPresenting ? dismissedFrame : presentedFrame
    let finalFrame = self.isPresenting ? presentedFrame : dismissedFrame
    
    controller.view.frame = initalFrame
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    if self.isPresenting {
                      toView.transform = .identity
                    } else {
                      //scaleBy cannot down to zero due to transfrom matrix
                      fromView.transform = transform.scaledBy(x: self.zoomScale, y: self.zoomScale)
                    }
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
