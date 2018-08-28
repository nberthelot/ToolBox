//
//  TBTabbarcontroller.swift
//  POCTabbar
//
//  Created by Berthelot Nicolas on 01/03/2018.
//  Copyright © 2018 Berthelot Nicolas. All rights reserved.
//

import Foundation
import UIKit

private class TabbarItem {
  var tabbarItemView:  UIView
  var tabbarButton: UIButton
  var keepControllerInMemory: Bool
  var controller: UIViewController?

  init(tabbarItemView: UIView, tabbarButton: UIButton, keepControllerInMemory: Bool) {
    self.tabbarItemView = tabbarItemView
    self.tabbarButton = tabbarButton
    self.keepControllerInMemory = keepControllerInMemory
  }
  
}

open class TBTabbarViewController: UIViewController {
  
  open var heightTabbar: CGFloat { return 49 }
  open var startingTabIndex: Int { return 0 }
  open var controllersCount: Int { return 0 }
  public fileprivate(set) var currentTabControllerIndex: Int = -1 // startingValue
  public var containerView = UIView()
  public var tabbarView = UIView()
  public var tabbarItemContainerView = UIView()
  public var containerViewHeightConstraint: NSLayoutConstraint?
  
  private var tabbarItems = [TabbarItem]()
  private var stackView = UIStackView()
  private var currentAnimator: UIViewPropertyAnimator?
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    prepapre()
  }
  
  open func loadController(at index: Int) -> UIViewController? {
    return nil
  }
  
  open func keepControllerInMemory(at index: Int) -> Bool {
    return true
  }
  
  open func didSelect(itemView: UIView, at index: Int) { }
  open func didDeselect(itemView: UIView, at index: Int) { }
  open func canSelect(itemAt index: Int) -> Bool { return true }
  open func prepare(itemView: UIView, with button: UIButton, at index: Int) { }
  
  open func animation(fromIndex: Int,
                      from fromController: UIViewController,
                      toIndex: Int,
                      to toController: UIViewController) -> UIViewPropertyAnimator?  {
    return nil
  }
  
  open func prepareTabbarItemContainerView() {
    tabbarItemContainerView.backgroundColor = .clear
    tabbarItemContainerView.translatesAutoresizingMaskIntoConstraints = false
    tabbarItemContainerView.topAnchor.constraint(equalTo: tabbarView.topAnchor).isActive = true
    tabbarItemContainerView.leftAnchor.constraint(equalTo: tabbarView.leftAnchor).isActive = true
    tabbarItemContainerView.rightAnchor.constraint(equalTo: tabbarView.rightAnchor).isActive = true
    tabbarItemContainerView.heightAnchor.constraint(equalToConstant: heightTabbar).isActive = true
  }
  
  open override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    for (index, tabbarItem) in tabbarItems.enumerated() {
      if index != self.currentTabControllerIndex, let controller = tabbarItem.controller {
        self.remove(controller, fromContainerView: containerView, removeView: true)
        tabbarItem.controller = nil
      }
    }
  }
  
}

extension TBTabbarViewController {
  
  fileprivate func prepapre() {
    prepareContainerView()
    prepareTabbar()
    selectController(at: startingTabIndex, animated: false)
  }
  
  fileprivate func prepareContainerView() {
    view.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
    containerViewHeightConstraint?.isActive = true
    containerView.backgroundColor = .clear
  }
  
  fileprivate func prepareTabbar() {
    view.addSubview(tabbarView)
    tabbarView.translatesAutoresizingMaskIntoConstraints = false
    tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tabbarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tabbarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    let safeBottomAnchor: NSLayoutYAxisAnchor
    if #available(iOS 11.0, tvOS 11.0, *) {
      safeBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
    } else {
      safeBottomAnchor = view.bottomAnchor
    }
    tabbarView.topAnchor.constraint(equalTo:safeBottomAnchor, constant: -heightTabbar).isActive = true
    tabbarView.backgroundColor = .clear
    prepareItemViews()
    
    tabbarView.addSubview(tabbarItemContainerView)
    prepareTabbarItemContainerView()
  }
  
}

// MARK: - TABARITEMVIEW
extension TBTabbarViewController {
  
  fileprivate func prepareItemViews() {
    tabbarItemContainerView.addSubview(stackView)
    stackView.x_fitTo(tabbarItemContainerView)
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    stackView.axis = .horizontal
    for index in 0..<controllersCount {
      insertTabbarItem(at: index)
    }
  }
  
  @objc fileprivate func didTapOn(button: UIButton) {
    guard button.tag >= 0 && button.tag < tabbarItems.count else {
      return
    }
    selectController(at: button.tag, animated: true)
  }
  
  private func updateButtonTags() {
    for (index, tabbarItem) in tabbarItems.enumerated() {
      tabbarItem.tabbarButton.tag = index
    }
  }
  
}

// MARK: - CONTROLLER
extension TBTabbarViewController {
  
  public func insertTabbarItem(at index: Int) {
    guard index >= 0 && index <= tabbarItems.count else { return }
    let v = UIView()
    let button = UIButton()
    v.backgroundColor = .clear
    prepare(itemView: v, with: button, at: index)
    v.addSubview(button)
    button.x_fitTo(v)
    button.addTarget(self, action: #selector(didTapOn(button:)), for: .touchUpInside)
    button.isSelected = false
    stackView.insertArrangedSubview(v, at: index)
    let item = TabbarItem(tabbarItemView: v, tabbarButton: button, keepControllerInMemory: self.keepControllerInMemory(at: index))
    tabbarItems.insert(item, at: index)
    if currentTabControllerIndex == index {
      currentTabControllerIndex += 1
    }
    updateButtonTags()
  }
  
  public func removeTabbarItem(at index: Int) {
    guard index >= 0 && index <= tabbarItems.count, let tabbarItem = tabbarItem(at: index) else { return }
    didDeselect(itemView: tabbarItem.tabbarItemView, at: index)
    tabbarItems.remove(at: index)
    stackView.removeArrangedSubview(tabbarItem.tabbarItemView)
    tabbarItem.tabbarItemView.removeFromSuperview()
    if let controller = tabbarItem.controller {
      remove(controller, fromContainerView: containerView, removeView: true)
      tabbarItem.controller = nil
    }
    updateButtonTags()
    if currentTabControllerIndex == index {
      self.selectController(at: max(0, currentTabControllerIndex - 1), animated: true, forceReload: true)
    }
    else if currentTabControllerIndex >= index {
      currentTabControllerIndex = max(0, currentTabControllerIndex - 1)
    }
  }
  
  private func tabbarItem(at index: Int) -> TabbarItem? {
    return index >= 0 && index < tabbarItems.count ? tabbarItems[index] : nil
  }
  
  private func memoryController(at index: Int) -> UIViewController? {
    return tabbarItem(at: index)?.controller
  }
  
  fileprivate func add(_ childViewController: UIViewController, inContainerView container: UIView) {
    remove(childViewController, fromContainerView: container, removeView: true)
    addChildViewController(childViewController)
    container.addSubview(childViewController.view)
    childViewController.view.x_fitTo(container)
    childViewController.didMove(toParentViewController: self)
  }
  
  fileprivate func remove(_ childViewController: UIViewController, fromContainerView container: UIView, removeView: Bool) {
    childViewController.removeFromParentViewController()
    if removeView {
      childViewController.view.removeFromSuperview()
    }
    childViewController.didMove(toParentViewController: nil)
  }
  
}

// MARK: - CONTROLS
extension TBTabbarViewController {
  
  @discardableResult
  public func selectController(at index: Int, animated: Bool = true, forceReload: Bool = false) -> Bool {
    guard currentAnimator == nil, canSelect(itemAt: index), (forceReload == true || index != currentTabControllerIndex),
      let tabbarItem = tabbarItem(at: index),
      let controller = (memoryController(at: index) ?? loadController(at: index)) else {
        return false
    }
    
    let currentTabbarItem = self.tabbarItem(at: currentTabControllerIndex)
    if let item = currentTabbarItem {
      item.tabbarButton.isSelected = false
      didDeselect(itemView: item.tabbarItemView, at: currentTabControllerIndex)
    }

    tabbarItem.controller = controller
    add(controller, inContainerView: containerView)
    tabbarItem.tabbarButton.isSelected = true
    didSelect(itemView: tabbarItem.tabbarItemView, at: index)
    let oldIndex = currentTabControllerIndex
    currentTabControllerIndex = index
 
    let completion: () -> () = {
      if let currentController = currentTabbarItem?.controller {
        self.remove(currentController, fromContainerView: self.containerView, removeView: true)
      }
      //Remove from memory if needed
      if currentTabbarItem?.keepControllerInMemory == false {
        currentTabbarItem?.controller = nil
      }
    }
    
    if animated == true, let currentController = currentTabbarItem?.controller, let animator = animation(fromIndex: oldIndex, from: currentController, toIndex: index, to: controller) {
      currentAnimator = animator
      animator.addCompletion({ _ in
        completion()
        self.currentAnimator = nil
      })
      animator.startAnimation()
    }
    else {
      completion()
    }
    return true
  }
  
}

