//
//  QMenu.swift
//  QTransition_Example
//
//  Created by Zefeng Qiu on 2017-12-02.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import QLayoutor
import QTransition

protocol QMenuDelegate: class {
  func selectTransition(_ menu: QMenu, transition: QTransition)
}

class QMenu: UIViewController
{
  weak var delegate: QMenuDelegate?
  
  static let menuWidth: CGFloat = 200
  static let menuHeight: CGFloat = 300
  let margin: CGFloat = 44
  
  private let transitions: [QTransition] = [QTransition(option: .push),
                                            QTransition(option: .fade),
                                            QTransition(option: .zoom),
                                            QTransition(slideDirection: .left),
                                            QTransition(slideDirection: .right),
                                            QTransition(slideDirection: .top),
                                            QTransition(slideDirection: .bottom),
                                            QTransition(pageDirection: .left)]
  
  var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = UIColor.clear
    table.tableFooterView = UIView(frame: CGRect.zero)
    return table
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.setupTableView()
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.view.addSubview(self.tableView)
    self.tableView.sameLeftRightAroundInSuperView(superview: self.view, padding: 0)
    self.tableView.setTopLayoutGuide(padding: self.margin, superVC: self)
    self.tableView.setBottomLayoutGuide(padding: 0, superVC: self)
  }
  
}

extension QMenu: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.transitions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    switch indexPath.row {
    case 0:
      cell.textLabel?.text = "push"
      return cell
    case 1:
      cell.textLabel?.text = "fade"
      return cell
    case 2:
      cell.textLabel?.text = "zoom"
      return cell
    case 3:
      cell.textLabel?.text = "zoom slide left"
      return cell
    case 4:
      cell.textLabel?.text = "zoom slide right"
      return cell
    case 5:
      cell.textLabel?.text = "zoom slide top"
      return cell
    case 6:
      cell.textLabel?.text = "zoom slide bottom"
      return cell
    default:
      cell.textLabel?.text = "page (left)"
      return cell
    }
  }
  
}

extension QMenu: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.selectTransition(self, transition: self.transitions[indexPath.row])
  }
  
}
