//
//  NewViewController.swift
//  QTransition_Example
//
//  Created by Zefeng Qiu on 2017-11-28.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import QLayoutor
import QTransition

class NewViewController: UIViewController {
  
  lazy var transition = QTransition(option: .push)
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let square = UIView()
    square.layer.cornerRadius = 5.0
    square.backgroundColor = UIColor.red
    square.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(square)
    
    square.setWidthHeight(width: 100, height: 100)
    square.centerOfItsSuperView(self.view, priority: Priority.max)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
