//
//  FeatureFlippingViewController.swift
//  ToolBox_Example
//
//  Created by Berthelot Nicolas on 03/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToolBox

class FeatureFlippingViewController: UIViewController, TBRoutable, TBSValidateServiceDependencies {
  static var mandatoryServices: [DependencyType] {
    return []
  }
  
  
  @IBOutlet weak var fooStatusLabel: UILabel!
  @IBOutlet weak var barStatusLabel: UILabel!
  @IBOutlet weak var fooSwitch: UISwitch!
  @IBOutlet weak var barSwitch: UISwitch!

  public static func loadController(with data: Any?, for route: String) -> UIViewController? {
    x_validateMandatoryServices()
    return self.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepare()
  }
  
}

// MARK:- PREPARE
extension FeatureFlippingViewController {
  
  private func prepare() {
    NotificationCenter.default.addObserver(forName: .tbFeaturesDidChange, object: nil, queue: .main) { [weak self] (_) in
      self?.reloadLabels()
    }
    reloadLabels()
    fooSwitch.isOn = TBFeature.isEnabled(.foo)
    barSwitch.isOn = TBFeature.isEnabled(.bar)
  }
  
  private func reloadLabels() {
    fooStatusLabel.text = TBFeature.isEnabled(.foo) ? "Enabled" : "Disabled"
    barStatusLabel.text = TBFeature.isEnabled(.bar) ? "Enabled" : "Disabled"
  }
  
}
  
// MARK:- ACTIONs
extension FeatureFlippingViewController {
  
  @IBAction func tappedOnCloseButton(_ sender: Any) {
    x_dismiss()
  }
  
  @IBAction func fooSwitchValueDidChanged(_ sender: UISwitch) {
    TBFeature.set(.foo, enabled: sender.isOn)
  }
  
  @IBAction func barSwitchValueDidChanged(_ sender: UISwitch) {
    TBFeature.set(.bar, enabled: sender.isOn)
  }
  
}
