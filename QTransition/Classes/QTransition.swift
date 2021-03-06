//
//  QTransition.swift
//  Pods-QTransition_Example
//
//  Created by Zefeng Qiu on 2017-11-26.
//

import UIKit

open class QTransition: NSObject {
  
  /// toVC is the view controller which is going to be presented
  public weak var toViewController: UIViewController?
  
  /// fromVC is always the view controller which is going to dismiss
  public weak var fromViewController: UIViewController?
  
  public var transition: QBaseTransition?
  
  public lazy var interactionController: QPanInteractionController = QPanInteractionController()
  
  var isPresentInteractive: Bool = false
  var isDismissInteractive: Bool = false
  
  public convenience init(option: QTransitionConstant.Options = .push) {
    self.init()
    
    switch option {
    /** TO Add New Transition Options:
       case .newTransitionOption:
       let transition = NewTransition()
       transition.specialProperty = value
       self.transition = transition
     */
    case .fade:
      self.transition = QFadeTransition()
      
    case .zoom:
      self.transition = QZoomTransition()
      
    default:
      self.transition = QPushTransition()
    }
  }
  
  public convenience init(menuHorizontalDirection: QTransitionConstant.Options.HorizontalSlide = .left, menuWidth: CGFloat) {
    self.init()
    let transition = QSlideTransition()
    transition.direction = menuHorizontalDirection == .left ? .left : .right
    transition.menuWidth = menuWidth
    self.transition = transition
  }
  
  public convenience init(menuVerticalDirection: QTransitionConstant.Options.VerticalSlide = .top, menuHeight: CGFloat) {
    self.init()
    let transition = QSlideTransition()
    transition.direction = menuVerticalDirection == .top ? .top : .bottom
    transition.menuHeight = menuHeight
    self.interactionController.gestureEdges = menuVerticalDirection == .top ? .top : .bottom
    self.transition = transition
  }
  
  public convenience init(slideDirection: QTransitionConstant.Options.ZoomSlide, zoomScale: CGFloat = 0.7) {
    self.init()
    let transition = QZoomSlideTransition()
    transition.direction = slideDirection
    transition.zoomScale = zoomScale
    self.transition = transition
  }
  
  public convenience init(pageDirection: QTransitionConstant.Options.Page) {
    self.init()
    let transition = QPageTransition()
    transition.direction = pageDirection
    self.transition = transition
  }
  
  /**
   Set from and to view controller to QTransition.
   
   - Parameter from: from view controller in view transitioning.
   - Parameter to: to view controller in view transitioning.
   - Parameter leaveInteractive: wire interaction controller for dismiss.
   - Parameter enterInteractive: wire interaction controller for present
   */
  public func setViewControllers(from: UIViewController, to: UIViewController, leaveInteractive: Bool, enterInteractive: Bool = false) {
    self.fromViewController = from
    self.toViewController = to
    self.isPresentInteractive = enterInteractive
    self.isDismissInteractive = leaveInteractive
    
    if leaveInteractive {
      self.interactionController.wireTo(fromVC: self.fromViewController!, toVC: self.toViewController!, isPresentWithGesture: enterInteractive)
    }
  }
  
}

//MARK: UIKit protocol conformance

extension QTransition: UIViewControllerTransitioningDelegate {
  
  public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let trans = self.transition else { return nil }
    trans.isPresenting = true
    return trans
  }
  
  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let trans = self.transition else { return nil }
    trans.isPresenting = false
    return trans
  }
  
  public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    self.interactionController.isPresenting = true
    return self.isPresentInteractive && self.interactionController.inProgress ? self.interactionController : nil
  }

  public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    self.interactionController.isPresenting = false
    return self.isDismissInteractive && self.interactionController.inProgress ? self.interactionController : nil
  }
  
  public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    // slide transition is for present and dismiss menu
    if let slideTransition = self.transition as? QSlideTransition {
      let presentationController = QSlideInPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: slideTransition.direction,
                                                                   menuWidth: slideTransition.menuWidth)
      self.interactionController.preparePanDismissGesture(in: presentationController.dimmingView)
      return presentationController
    }

    if self.transition is QPushTransition {
      let presentationController = QDimmingPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   dimmingAlpha: 0.6)
      return presentationController
    }

    return nil
  }
  
}

extension QTransition: UINavigationControllerDelegate {
  
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let trans = self.transition else { return nil }
    trans.operation = operation
    return trans
  }
  
  public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    guard let trans = self.transition else { return nil }
    return trans.inProgress ? trans : nil
  }
  
}
