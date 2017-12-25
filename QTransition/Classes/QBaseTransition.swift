//
//  QBaseTransition.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-26.
//

import UIKit

open class QBaseTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
  
  public var isPresenting: Bool = true
  public var operation: UINavigationControllerOperation?
  
  /// properties for interactive transition
  public lazy var gestureEdge: UIRectEdge = .left
  public lazy var inProgress: Bool = false
  public var navigationController: UINavigationController?
  private lazy var shouldCompleteTransition = false
  private weak var viewController: UIViewController?
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return QTransitionConstant.duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    // fromVC is always the view controller which is going to dismiss
    guard let fromVC = transitionContext.viewController(forKey: .from) else {
      QLog("Key for from view controller is nil", type: .error)
      return
    }
    //toVC is the view controller which is going to be presented
    guard let toVC = transitionContext.viewController(forKey: .to) else {
      QLog("Key for to view controller is nil", type: .error)
      return
    }
    
    guard let fromView = fromVC.view else {
      QLog("view of from view controller is nil", type: .error)
      return
    }
    
    guard let toView = toVC.view else {
      QLog("view of to view controller is nil", type: .error)
      return
    }
    
    self.animateTransition(using: transitionContext, fromVC: fromVC, fromView: fromView, toVC: toVC, toView: toView)
  }
  
  /**
   Subclass require to override this function
   */
  open func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView) {
    preconditionFailure("This method must be overridden in subclass")
  }
  
  //MARK: - Pop view from navigation stack interactively
  
  /**
   Wire from view controller and adding screen edge pan gesture recognizer.
   
   - Parameter viewController: from view controller.
   - Parameter navigationController: from view navigation controller.
   */
  open func wireToDismiss(viewController: UIViewController, with navigationController: UINavigationController?) {
    self.viewController = viewController
    self.navigationController = navigationController
    let gesture = UIScreenEdgePanGestureRecognizer(target: self,
                                                   action: #selector(QPushTransition.handleDismissPan(recognizer:)))
    gesture.edges = self.gestureEdge
    self.viewController?.view.addGestureRecognizer(gesture)
  }
  
  @objc open func handleDismissPan(recognizer: UIScreenEdgePanGestureRecognizer) {
    let translation = recognizer.translation(in: recognizer.view?.superview)
    guard let width = recognizer.view?.superview?.frame.width else {
      QLog("recognizer view's super view width is nil", type: .warning)
      return
    }
    
    // linear progress in interactive process
    var progress = translation.x / width
    progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
    
    switch recognizer.state {
    case .began:
      self.inProgress = true
      self.navigationController?.popViewController(animated: true)
      
    case .changed:
      self.shouldCompleteTransition = progress > 0.35
      self.update(progress)
      
    case .cancelled:
      self.inProgress = false
      self.cancel()
      
    case .ended:
      self.inProgress = false
      if !self.shouldCompleteTransition {
        self.cancel()
      }else {
        self.finish()
      }
      
    default:
      break
    }
    
  }
  
}
