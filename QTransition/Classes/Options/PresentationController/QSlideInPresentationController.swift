//
//  QSlideInPresentationController.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-27.
//

import UIKit

public final class QSlideInPresentationController: UIPresentationController {
  var dimmingView: UIView = UIView()
  var dimmingAlpha: CGFloat = QTransitionConstant.dimmingAlpha
  var direction: QTransitionConstant.Direction
  var menuWidth: CGFloat
  
  override public var shouldRemovePresentersView: Bool {
    return false
  }
  
  override public var frameOfPresentedViewInContainerView: CGRect {
    var frame: CGRect = .zero
    frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
    switch direction {
    case .right:
      frame.origin.x = (containerView?.frame.width)! - self.menuWidth
    case .bottom:
      frame.origin.y = containerView!.frame.height*(1.0/3.0)
    default:
      frame.origin = .zero
    }
    return frame
  }
  
  public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction:  QTransitionConstant.Direction, menuWidth: CGFloat) {
    self.direction = direction
    self.menuWidth = menuWidth
    
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    self.setupDimmingView()
  }
  
  override public func presentationTransitionWillBegin() {
    if let container = self.containerView {
      container.insertSubview(self.dimmingView, at: 0)
      self.dimmingView.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
      self.dimmingView.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
      self.dimmingView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
      self.dimmingView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
      
      guard let coordinator = self.presentedViewController.transitionCoordinator else {
        self.dimmingView.alpha = 1.0
        return
      }
      
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      })
    }
  }
  
  override public func presentationTransitionDidEnd(_ completed: Bool) {
    if !completed {
      self.dimmingView.removeFromSuperview()
    }
  }
  
  override public func dismissalTransitionWillBegin() {
    guard let coordinator = self.presentedViewController.transitionCoordinator else {
      self.dimmingView.alpha = 0.0
      return
    }
    
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  
  override public func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      self.dimmingView.removeFromSuperview()
    }
  }
  
  override public func containerViewWillLayoutSubviews() {
    self.presentedView?.frame = self.frameOfPresentedViewInContainerView
  }
  
  override public func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    switch direction {
    case .left, .right:
      return CGSize(width: self.menuWidth, height: parentSize.height)
    case .bottom, .top:
      return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
    }
  }
  
  func setupDimmingView() {
    self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
    self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: self.dimmingAlpha)
    self.dimmingView.alpha = 0.0
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(QSlideInPresentationController.handleTap))
    self.dimmingView.addGestureRecognizer(tap)
  }
  
  @objc func handleTap() {
    self.presentingViewController.dismiss(animated: true, completion: nil)
  }
  
}

