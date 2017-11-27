//
//  QTransitionConstant.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-26.
//

import UIKit

public class QTransitionConstant {
  
  public enum TransitionOptions {
    case push
    case slideLeft
    case slideRight
    case slideTop
    case slideBottom
  }
  
  public static var duration: TimeInterval = 0.36
  public static var interactiveSpeed: CGFloat = 200
  public static var dimmingAlpha: CGFloat = 0.5
  
}

