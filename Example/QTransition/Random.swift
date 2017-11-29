//
//  Random.swift
//  QTransition_Example
//
//  Created by Zefeng Qiu on 2017-11-28.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

/// generate random color: https://stackoverflow.com/questions/29779128/how-to-make-a-random-background-color-with-swift

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}

extension UIColor {
  static func random() -> UIColor {
    return UIColor(red:   .random(),
                   green: .random(),
                   blue:  .random(),
                   alpha: 1.0)
  }
}
