//
//  QLayoutor.swift
//  QLayoutor
//
//  Created by Zefeng Qiu on 2017-11-26.
//  Copyright © 2017 Zefeng Qiu. All rights reserved.
//

import UIKit

extension UIView
{
  /**
   Layout item in center of its super view
   
   - Parameter axis: decide on center X or Y.
   - Parameter superView: view item's superview.
   - Parameter priority: layout priority, default is high.
   */
  public func center(on axis: Axis, in superview: UIView, priority: UILayoutPriority = Priority.high)
  {
    if axis == .x {
      let layoutX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
      layoutX.priority = priority
      layoutX.isActive = true
    }else {
      let layoutY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
      layoutY.priority = priority
      layoutY.isActive = true
    }
  }
  
  /**
   Layout item in center of its super view
   
   - Parameter superView: view item's superview.
   - Parameter priority: layout priority, default is high.
   */
  public func centerOfItsSuperView(_ superview: UIView, priority: UILayoutPriority = Priority.high) {
    self.center(on: .x, in: superview, priority: priority)
    self.center(on: .y, in: superview, priority: priority)
  }
  
  /**
   Layout item with left and right padding around.
   
   - Parameter superView: item's superview.
   - Parameter leftPadding: left distance to item's superview.
   - Parameter rightPadding: right distance to item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func withLeftRightAroundInSuperView(_ superview: UIView, paddingLeft: CGFloat, paddingRight: CGFloat, priority: UILayoutPriority = Priority.normal) {
    let layoutLeft = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1.0, constant: paddingLeft)
    layoutLeft.priority = priority
    layoutLeft.isActive = true
    
    let layoutRight = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1.0, constant: -paddingRight)
    layoutRight.priority = priority
    layoutRight.isActive = true
  }
  
  /**
   Layout item with left and right padding around.
   
   - Parameter superView: item's superview.
   - Parameter padding: left and right distance to item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func sameLeftRightAroundInSuperView(superview: UIView, padding: CGFloat, priority: UILayoutPriority = Priority.normal) {
    self.withLeftRightAroundInSuperView(superview, paddingLeft: padding, paddingRight: padding, priority: priority)
  }
  
  /**
   Layout item with top and bottom padding around.
   
   - Parameter superView: item's superview.
   - Parameter topPadding: top distance to item's superview.
   - Parameter bottomPadding: bottom distance to item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func withTopBottomAroundInSuperView(_ superview: UIView, paddingTop: CGFloat, paddingBottom: CGFloat, priority: UILayoutPriority = Priority.normal) {
    let layoutTop = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: paddingTop)
    layoutTop.priority = priority
    layoutTop.isActive = true
    
    let layoutBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: -paddingBottom)
    layoutBottom.priority = priority
    layoutBottom.isActive = true
  }
  
  /**
   Layout item with top and bottom padding around.
   
   - Parameter superView: item's superview.
   - Parameter padding: top and bottom distance to item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func sameTopBottomAroundInSuperView(_ superview: UIView, padding: CGFloat = 0, priority: UILayoutPriority = Priority.normal) {
    self.withTopBottomAroundInSuperView(superview, paddingTop: padding, paddingBottom: padding, priority: priority)
  }
  
  /**
   Layout item with setting its height and width.
   
   - Parameter height: item's height.
   - Parameter width: item's width.
   - Parameter priority: layout priority, default is normal.
   */
  public func setWidthHeight(width: CGFloat, height: CGFloat, priority: UILayoutPriority = Priority.normal) {
    let layoutWidth = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
    layoutWidth.priority = priority
    layoutWidth.isActive = true
    
    let layoutHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
    layoutHeight.priority = priority
    layoutHeight.isActive = true
  }
  
  /**
   Setting item top layout.
   
   - Parameter padding: padding from item to superview.
   - Parameter superview: item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func setTop(padding: CGFloat, superview: UIView, priority: UILayoutPriority = Priority.normal)
  {
    let layoutTop = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant:  padding)
    layoutTop.priority = priority
    layoutTop.isActive = true
  }
  
  /**
   Setting item top layout using Top Layout Guide.
   
   - Parameter padding: padding from item to superview.
   - Parameter superview: item's superview.
   - Parameter priority: layout priority, default is high.
   */
  public func setTopLayoutGuide(padding: CGFloat, superVC: UIViewController, priority: UILayoutPriority = Priority.high)
  {
    // in iOS 11 change to save area layout guide
    if #available(iOS 11, *) {
      let guide = superVC.view.safeAreaLayoutGuide
      let topGuide = self.topAnchor.constraint(equalTo: guide.topAnchor, constant: padding)
      topGuide.priority = priority
      topGuide.isActive = true
    }else
    {
      let topGuide = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superVC.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant:  padding)
      topGuide.priority = priority
      topGuide.isActive = true
    }
  }
  
  /**
   Setting item bottom layout.
   
   - Parameter padding: padding from item to superview.
   - Parameter superview: item's superview.
   - Parameter priority: layout priority, default is normal.
   */
  public func settBottom(padding: CGFloat, superview: UIView, priority: UILayoutPriority = Priority.normal) {
    let layoutBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: -padding)
    layoutBottom.priority = priority
    layoutBottom.isActive = true
  }
  
  /**
   Setting item top layout using Bottom Layout Guide.
   
   - Parameter padding: padding from item to superview.
   - Parameter superview: item's superview.
   - Parameter priority: layout priority, default is high.
   */
  public func setBottomLayoutGuide(padding: CGFloat, superVC: UIViewController, priority: UILayoutPriority = Priority.high) {
    // in iOS 11 change to save area layout guide
    if #available(iOS 11, *) {
      let guide = superVC.view.safeAreaLayoutGuide
      let bottomGuide = self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: padding)
      bottomGuide.priority = priority
      bottomGuide.isActive = true
    }else {
      let bottomGuide = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superVC.bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant:  padding)
      bottomGuide.priority = priority
      bottomGuide.isActive = true
    }
  }
  
}
