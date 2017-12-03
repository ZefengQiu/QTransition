//
//  QTransitionConstant.swift
//  Pods
//
//  Created by Zefeng Qiu on 2017-11-26.
//

import UIKit

public struct QTransitionConstant {
  
  public enum Direction {
    case left
    case right
    case top
    case bottom
  }
  
  public enum TransitionOptions {
    case push
    // Top and Bottom has not been implement yet, Slide is mostly for presenting menu 
    case slideLeft
    case slideRight
    case slideTop
    case slideBottom
  }
  
  public static var duration: TimeInterval = 0.36
  public static var dimmingAlpha: CGFloat = 0.5
  
}

