//
//  TBScrollViewWithHeaderViewController.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 14/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

open class TBScrollViewWithHeaderViewController: UIViewController, UIScrollViewDelegate  {
  
  public var headerContainer: UIView = UIView()
  open var headerHeight: CGFloat { return UIScreen.main.bounds.height * 0.40 }
  open var headerHeightConstraint: NSLayoutConstraint!
  open var scrollView: UIScrollView { return UIScrollView() }

  open override func viewDidLoad() {
    super.viewDidLoad()
    prepareContainerView()
    prepareScrollView()
  }
  
  open func prepareContainerView() {
    headerContainer = loadHeaderContainer()
    view.addSubview(headerContainer)
    headerContainer.translatesAutoresizingMaskIntoConstraints = false
    headerContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    headerContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    headerContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    headerHeightConstraint = headerContainer.heightAnchor.constraint(equalToConstant: headerHeight)
    headerHeightConstraint.isActive = true
    headerContainer.backgroundColor = .red
    view.sendSubview(toBack: headerContainer)
  }
  
  open func prepareScrollView() {
    scrollView.contentInset.top = headerHeight + 0
    scrollView.delegate = self
  }
  
  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let normalizedOffset = scrollView.contentOffset.y + scrollView.contentInset.top
    let newY = -normalizedOffset
    let scaleX = newY > 0 ? 1 + newY / headerHeight : 1
    headerContainer.transform = CGAffineTransform(translationX: 0, y:  min(newY, 0)).concatenating(CGAffineTransform(scaleX: scaleX, y: scaleX))
  }
  
  open func loadHeaderContainer() -> UIView {
    return UIView()
  }
  
}
