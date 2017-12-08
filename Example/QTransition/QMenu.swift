//
//  QMenu.swift
//  QTransition_Example
//
//  Created by Zefeng Qiu on 2017-12-02.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import QLayoutor

class QMenu: UIViewController
{
  static let menuWidth: CGFloat = 200
  static let menuHeight: CGFloat = 250
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .clear
    self.setupSideMenu()
  }
  
  private func setupSideMenu() {
    let row0 = UIStackView()
    let row1 = UIStackView()
    let row2 = UIStackView()
    let container = UIStackView()
    
    container.backgroundColor = UIColor.clear
    container.axis = .vertical
    container.spacing = 30
    container.alignment = .center
    container.distribution = .fillProportionally
    container.translatesAutoresizingMaskIntoConstraints = false
    row0.backgroundColor = UIColor.clear
    row0.axis = .horizontal
    row0.spacing = 30
    row0.alignment = .center
    row0.distribution = .fillProportionally
    row0.translatesAutoresizingMaskIntoConstraints = false
    row1.backgroundColor = UIColor.clear
    row1.axis = .horizontal
    row1.spacing = 30
    row1.alignment = .center
    row1.distribution = .fillProportionally
    row1.translatesAutoresizingMaskIntoConstraints = false
    row2.backgroundColor = UIColor.clear
    row2.axis = .horizontal
    row2.spacing = 30
    row2.alignment = .center
    row2.distribution = .fillProportionally
    row2.translatesAutoresizingMaskIntoConstraints = false
    
    for _ in 0..<3
    {
      let label = self.createLabel()
      row0.addArrangedSubview(label)
    }
    
    for _ in 0..<3
    {
      let label = self.createLabel()
      row1.addArrangedSubview(label)
    }
    
    for _ in 0..<3
    {
      let label = self.createLabel()
      row2.addArrangedSubview(label)
    }
    
    self.view.addSubview(container)
    container.addArrangedSubview(row0)
    container.addArrangedSubview(row1)
    container.addArrangedSubview(row2)
    
    container.centerOfItsSuperView(self.view)
  }
  
  private func createLabel() -> UILabel {
    let label = UILabel()
    label.clipsToBounds = true
    label.textAlignment = .center
    label.backgroundColor = UIColor.white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Q"
    label.layer.cornerRadius = 10
    label.setWidthHeight(width: 70, height: 70, priority: Priority.max)
    return label
  }
  
}
