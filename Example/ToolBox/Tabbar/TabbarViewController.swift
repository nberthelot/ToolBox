//
//  TabbarViewController.swift
//  ToolBox_Example
//
//  Created by Nicolas Berthelot on 29/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToolBox

public class TabbarViewController: TBTabbarViewController, TBRoutable {
  
  public static func loadController(with data: Any?, for route: String) -> UIViewController? {
    return self.init()
  }
  
  override public var controllersCount: Int { return 3 }

  public override func viewDidLoad() {
    super.viewDidLoad()
    tabbarView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
  }
  
  public override func loadController(at index: Int) -> UIViewController? {
    let viewContoller =  UIViewController()
    viewContoller.view.backgroundColor = .x_random
    if index == controllersCount - 1 {
      let label = UILabel()
      viewContoller.view.addSubview(label)
      label.x_fitTo(viewContoller.view)
      label.textAlignment = .center
      label.text = "This controller will be removed..."
    }
    return viewContoller
  }
  
  public override func keepControllerInMemory(at index: Int) -> Bool {
    return index != controllersCount - 1
  }
  
  public override func prepare(itemView: UIView, with button: UIButton, at index: Int) {
    button.setTitle("item \(index)", for: .normal)
    button.setTitleColor(.yellow, for: .normal)
    button.setTitleColor(.red, for: .selected)
  }

}
