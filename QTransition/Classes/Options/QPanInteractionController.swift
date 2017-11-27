//
//  QPanInteractionController.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-27.
//

import UIKit

public class QPanInteractionController: UIPercentDrivenInteractiveTransition {
  
  public var isPresenting: Bool = false
  public var gestureEdges: UIRectEdge = .left
  public var inProgress = false
  public var threshold: CGFloat = 0.3
  // note: best speed is equal to presenting vc view width
  public var speed: CGFloat?
  
  private var shouldCompleteTransition: Bool = false
  private var isPresentWithGesture: Bool = false
  private weak var fromVC: UIViewController!
  private weak var toVC: UIViewController!
  
  /**
   Wire from view controller and adding screen edge pan gesture recognizer.
   
   - Parameter viewController: from view controller.
   */
  public func wireTo(fromVC: UIViewController, toVC: UIViewController, isPresentWithGesture: Bool = false){
    self.completionCurve = .linear
    self.fromVC = fromVC
    self.toVC = toVC
    self.isPresentWithGesture = isPresentWithGesture
    self.speed = self.speed ?? toVC.view.frame.width
    
    if isPresentWithGesture {
      self.prepareEdgePresentGesture(in: fromVC.view)
      self.preparePanDismissGesture(in: toVC.view)
    }else {
      self.prepareEdgeDismissGesture(in: toVC.view)
    }
  }
  
  /**
   Calculate progress of view transition.
   */
  public func calculateInteractionProgress(translation: CGPoint) -> CGFloat {
    var progress: CGFloat = 0.0
    if self.gestureEdges == .right {
      progress = translation.x / self.speed! * -1
    }
    
    if self.gestureEdges == .left {
      progress = translation.x / self.speed!
    }
    
    if self.isPresentWithGesture {
      // this checking is for menu vc, there are pan gestures to dismiss menu
      progress = self.isPresenting ? progress : -progress
    }
    
    return min(progress, CGFloat(1.0))
  }
  
  /**
   Helper function for mapping gesture
   */
  public func mapGestureState(gestureState:UIGestureRecognizerState, progress:CGFloat, triggerFunction: () -> ()) {
    switch gestureState{
    case .began:
      self.inProgress = true
      triggerFunction()
    case .changed:
      self.shouldCompleteTransition = progress > threshold
      self.update(progress)
    case .cancelled:
      self.inProgress = false
      self.cancel()
    case .ended:
      self.inProgress = false
      self.shouldCompleteTransition ? self.finish() : self.cancel()
    default:
      break
    }
  }
  
  //MARK: - set up dismiss gesture
  
  func prepareEdgeDismissGesture(in view: UIView) {
    let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(QPanInteractionController.handleDismissGesture(gestureRecognizer:)))
    gesture.edges = self.gestureEdges
    view.addGestureRecognizer(gesture)
  }
  
  func preparePanDismissGesture(in view: UIView) {
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(QPanInteractionController.handleDismissGesture(gestureRecognizer:)))
    view.addGestureRecognizer(gesture)
  }
  
  @objc func handleDismissGesture(gestureRecognizer: UIPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
    let progress =  self.calculateInteractionProgress(translation: translation)
    
    self.mapGestureState(gestureState: gestureRecognizer.state,
                         progress: progress,
                         triggerFunction: {
                          self.toVC.dismiss(animated: true, completion: nil)
    })
  }
  
  //MARK: - set up present gesture
  
  func prepareEdgePresentGesture(in view: UIView) {
    let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(QPanInteractionController.handlePresentGesture(gestureRecognizer:)))
    gesture.edges = self.gestureEdges
    gesture.delegate = self
    view.addGestureRecognizer(gesture)
  }
  
  @objc func handlePresentGesture(gestureRecognizer: UIPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
    let progress =  self.calculateInteractionProgress(translation: translation)
    
    self.mapGestureState(gestureState: gestureRecognizer.state,
                         progress: progress,
                         triggerFunction: {
                          self.fromVC.present(self.toVC, animated: true, completion: nil)
    })
  }
  
}

extension QPanInteractionController: UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
