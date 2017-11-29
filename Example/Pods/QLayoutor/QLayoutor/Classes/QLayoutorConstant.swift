//
//  QLayoutorConstant.swift
//  QLayoutor
//
//  Created by Zefeng Qiu on 2017-11-26.
//  Copyright © 2017 Zefeng Qiu. All rights reserved.
//

import UIKit

public enum Axis {
  case x
  case y
}

public struct Priority {
  public static let max = UILayoutPriority(1000)
  public static let high = UILayoutPriority(800)
  public static let normal = UILayoutPriority(600)
  public static let low = UILayoutPriority(400)
  public static let min = UILayoutPriority(200)
}
