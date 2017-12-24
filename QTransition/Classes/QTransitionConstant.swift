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
    
    public enum ZoomSlide {
      case left
      case right
      case top
      case bottom
    }

  }
  
  public static var duration: TimeInterval = 0.20
  public static var dimmingAlpha: CGFloat = 0.5
  
}

enum LogType {
  case message, error, warning
}

func QLog(_ msg: String, type: LogType = .message) {
  switch type {
  case .message:
    print("---\(msg)---")
  case .warning:
    print("Warning: ###\(msg)###")
  default:
    print("Error: XXX\(msg)XXX")
  }

}

