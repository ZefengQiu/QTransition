//
//  QTransitionDelegate.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-26.
//

import UIKit

@objc public protocol QTransitionDelegate {
  
  @objc optional func transitionWillStartAnimating(from viewController: UIViewController)
  
  @objc optional func transitionDidEndAnimating(from viewController: UIViewController)
  
  @objc optional func transitionCancelAnimating(from viewControler: UIViewController)
  
  @objc optional func transitionWillStartAnimating(to viewController: UIViewController)
  
  @objc optional func transitionDidEndAnimating(to viewController: UIViewController)
  
  @objc optional func transitionCancelAnimating(to viewControler: UIViewController)
  
  @objc optional func transitionWillStart()
  
  @objc optional func transitionDidEnd()
  
  @objc optional func transitionDidCancel()
  
}
