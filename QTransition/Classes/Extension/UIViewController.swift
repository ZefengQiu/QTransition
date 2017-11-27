//
//  UIViewController.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-27.
//

import UIKit

public extension UIViewController {
  /**
   Present View Controller modally with view transition
   
   - Parameter to: to ViewController
   - Parameter transition: Q transition
   - Parameter isInteractive: is interactive transition on.
   - Parameter completion: completion handler to notify when present view controller is done.
   */
  public func present(to viewController: UIViewController, transition: QTransition, isInteractive: Bool, completion: (() -> Void)? = nil) {
    viewController.transitioningDelegate = transition
    viewController.modalPresentationStyle = .custom
    transition.setViewControllers(from: self, to: viewController, leaveInteractive: isInteractive)
    
    self.present(viewController, animated: true, completion: completion)
  }
  
  /**
   Present View Controller modally with view transition and view controller's navigation controller.
   
   - Parameter navigation: view controlelr's navigation Controller
   - Parameter with: with nav's ViewController
   - Parameter transition: Q transition
   - Parameter isInteractive: is interactive transition on.
   - Parameter completion: completion handler to notify when present view controller is done.
   */
  public func present(navigation: UINavigationController, with viewController: UIViewController, with  transition: QTransition, isInteractive: Bool, completion: (() -> Void)? = nil) {
    navigation.transitioningDelegate = transition
    navigation.modalPresentationStyle = .custom
    transition.setViewControllers(from: self, to: viewController, leaveInteractive: isInteractive)
    
    self.present(navigation, animated: true, completion: completion)
  }
  
  /**
   Present modal view controller interactively using interaction controller.
   
   - Parameter to: to ViewController
   - Parameter transition: Q transition
   */
  public func setupPresentInteractive(to viewController: UIViewController, transition: QTransition) {
    viewController.modalPresentationStyle = .custom
    viewController.transitioningDelegate = transition
    transition.setViewControllers(from: self, to: viewController, leaveInteractive : true, enterInteractive: true)
  }
  
  /**
   Present View Controller modally with view transition with navigation controller.
   
   - Parameter to: to ViewController.
   - Parameter transition: Q transition.
   - Parameter isInteractive: is interactive transition on.
   - Parameter completion: completion handler to notify when present view controller is done.
   */
  public func presentWithNav(to viewController: UIViewController, transition: QTransition, isInteractive: Bool, completion: (() -> Void)? = nil) {
    let nav = UINavigationController(rootViewController: viewController)
    nav.modalPresentationStyle = .custom
    nav.transitioningDelegate = transition
    transition.setViewControllers(from: self, to: viewController, leaveInteractive: isInteractive)
    
    self.present(nav, animated: true, completion: completion)
  }
  
  /**
   Push view controller onto the receiver’s stack and updates the display with view transition.
   
   - Parameter to: to ViewController
   - Parameter transition: Q transition
   - Parameter isInteractive: is interactive transition on.
   - Parameter completion: completion handler to notify when present view controller is done.
   */
  public func push(to viewController: UIViewController, isInteractive: Bool, transition: QTransition) {
    if let nav = self.navigationController {
      nav.delegate = transition
      if isInteractive {
        guard let trans = transition.transition else { return }
        trans.wireToDismiss(viewController: viewController, with: self.navigationController)
      }
      
      nav.pushViewController(viewController, animated: true)
    }
  }
  
}


