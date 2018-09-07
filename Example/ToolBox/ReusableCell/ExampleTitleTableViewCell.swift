//
//  ExampleTitleTableViewCell.swift
//  ToolBox_Example
//
//  Created by Nicolas Berthelot on 29/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToolBox

public class ExampleTitleTableViewCell: UITableViewCell, TBReusable {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  public func configure(with title: String?) {
    titleLabel.text = title
  }
  
}
