//
//  QDimmingPresentationController.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-27.
//

import UIKit

public class QDimmingPresentationController: UIPresentationController {
  
  public var dimmingAlpha: CGFloat
  lazy var dimmingView: UIView = UIView()
  
  override public var shouldRemovePresentersView: Bool {
    return false
  }
  
  override public var frameOfPresentedViewInContainerView: CGRect {
    var frame: CGRect = .zero
    frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
    frame.origin = CGPoint.zero
    return frame
  }
  
  public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, dimmingAlpha: CGFloat) {
    self.dimmingAlpha = dimmingAlpha
    
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    self.setupDimmingView()
  }
  
  override public func presentationTransitionWillBegin() {
    if let container = self.containerView
    {
      container.addSubview(self.dimmingView)
      QLayout.itemWithSameLeftRightAroundInSuperView(self.dimmingView, superview: container, padding: 0)
      QLayout.itemWithSameTopBottomAroundInSuperView(self.dimmingView, superview: container, padding: 0)
      
      guard let coordinator = self.presentedViewController.transitionCoordinator else {
        self.dimmingView.alpha = 1.0
        return
      }
      
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      })
    }
  }
  
  override public func presentationTransitionDidEnd(_ completed: Bool)
  {
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
    return CGSize(width: parentSize.width, height: parentSize.height)
  }
  
  //MARK: - Setup Dimming View and tap on it
  func setupDimmingView() {
    self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
    self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: self.dimmingAlpha)
    self.dimmingView.alpha = 0.0
  }
  
}
