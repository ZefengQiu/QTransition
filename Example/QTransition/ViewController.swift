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
  lazy var menuTransition = QTransition(menuHorizontalDirection: .left, menuWidth: QMenu.menuWidth)
  lazy var menu = QMenu()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //FOR: Inspect view transition
    //QTransitionConstant.duration = 2.0
    let demo = UIBarButtonItem(title: "DEMO",
                               style: .plain,
                               target: self,
                               action: #selector(ViewController.presentDemo))
    let menu = UIBarButtonItem(title: "MENU",
                               style: .plain,
                               target: self,
                               action: #selector(ViewController.presentMenu))
    self.navigationItem.rightBarButtonItem = demo
    self.navigationItem.leftBarButtonItem = menu
    self.setupSideMenu()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc private func presentDemo() {
    NewViewController.numOfNewVC = 0
    let newVC = NewViewController(transition: self.transition)
    let nav = UINavigationController(rootViewController: newVC)
    self.present(to: nav, transition: self.transition, isInteractive: true)
  }
  
  @objc private func presentMenu()
  {
    self.present(to: self.menu, transition: self.menuTransition, isInteractive: true)
  }
  
  @objc private func setupSideMenu() {
    self.menu.delegate = self
    self.menuTransition.interactionController.threshold = 0.25
    self.menuTransition.interactionController.speed = QMenu.menuHeight
    self.setupPresentInteractive(to: self.menu, transition: self.menuTransition)
  }
  
}

extension ViewController: QMenuDelegate {
  
  func selectTransition(_ menu: QMenu, transition: QTransition) {
    menu.dismiss(animated: true, completion: {
      self.transition = transition
    })
  }
  
}
