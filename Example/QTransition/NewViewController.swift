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
  
  var transition: QTransition
  
  static var numOfNewVC: Int = 0
  
  init(transition: QTransition) {
    self.transition = transition
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "# \(NewViewController.numOfNewVC) VC"
    NewViewController.numOfNewVC += 1
    self.view.backgroundColor = UIColor.lightGray
    let square = UIView()
    square.layer.cornerRadius = 5.0
    square.backgroundColor = UIColor.random()
    square.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(square)
    
    square.setWidthHeight(width: 100, height: 100)
    square.centerOfItsSuperView(self.view, priority: Priority.max)
    
    let next = UIBarButtonItem(title: "NEXT",
                               style: .plain,
                               target: self,
                               action: #selector(NewViewController.presentDemo))
    let back = UIBarButtonItem(title: "BACK",
                               style: .plain,
                               target: self,
                               action: #selector(NewViewController.dismissVC))
    self.navigationItem.rightBarButtonItem = next
    self.navigationItem.leftBarButtonItem = back
  }
  
  @objc private func presentDemo() {
    let newVC = NewViewController(transition: self.transition)
    let nav = UINavigationController(rootViewController: newVC)
    self.present(to: nav, transition: self.transition, isInteractive: true)
  }
  
  @objc private func dismissVC() {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
