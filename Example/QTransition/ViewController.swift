//
//  ViewController.swift
//  QTransition
//
//  Created by willqiu126 on 11/26/2017.
//  Copyright (c) 2017 willqiu126. All rights reserved.
//

import UIKit
import QTransition

class ViewController: UIViewController {
  
  lazy var transition = QTransition(option: .push)
  lazy var menuTransition = QTransition(option: .slideLeft, menuWidth: QMenu.sideWidth)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let demo = UIBarButtonItem(title: "DEMO",
                               style: .plain,
                               target: self,
                               action: #selector(ViewController.presentDemo))
    self.navigationItem.rightBarButtonItem = demo
    self.setupSideMenu()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc private func presentDemo() {
    let newVC = NewViewController()
    let nav = UINavigationController(rootViewController: newVC)
    self.present(to: nav, transition: self.transition, isInteractive: true)
  }
  
  @objc private func setupSideMenu() {
    let menu = QMenu()
    self.menuTransition.interactionController.threshold = 0.25
    self.menuTransition.interactionController.speed = QMenu.sideWidth
    self.setupPresentInteractive(to: menu, transition: self.menuTransition)
  }
  
}

