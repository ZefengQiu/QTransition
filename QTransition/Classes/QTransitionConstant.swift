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
  
  public enum Options {
    case push
    case fade
    case zoom
    
    public enum HorizontalSlide {
      case left
      case right
    }
    
    public enum VerticalSlide {
      case top
      case bottom
    }

  }
  
  public static var duration: TimeInterval = 0.36
  public static var dimmingAlpha: CGFloat = 0.5
  
}

