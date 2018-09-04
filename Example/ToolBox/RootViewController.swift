//
//  RootViewController.swift
//  ToolBox
//
//  Created by Berthelot nicolas on 08/28/2018.
//  Copyright (c) 2018 Berthelot nicolas. All rights reserved.
//

import UIKit
import ToolBox

class RootViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepare()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: - PREPARE
extension RootViewController {
  
  private func prepare() {
    tableView.x_registerReusableCell(ExampleTitleTableViewCell.self)
  }
  
}

//MARK: UITABLEVIEWDATASOURCE
extension RootViewController: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ExampleType.count.rawValue
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ExampleTitleTableViewCell = tableView.x_dequeueReusableCell(indexPath: indexPath)
    cell.configure(with: ExampleType.init(rawValue: indexPath.row)?.name)
    return cell
  }
  
}

//MARK: UITABLEVIEWDELEGATE
extension RootViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let exampleType = ExampleType(rawValue: indexPath.row) else { return }
    switch exampleType {
    case .tabbar:
      x_performRoute("tabbar", presentationType: .modal)
    case .featureFlipping:
      x_performRoute("featureFlipping", presentationType: .modal)
    case .count: break
    }
  }
  
}

extension RootViewController {
  
  enum ExampleType: Int {
    
    case tabbar = 0
    case featureFlipping

    case count

    var name: String {
      switch self {
      case .tabbar: return "Tabbar"
      case .featureFlipping: return "Feature Flipping"
      case .count: return "count"
      }
    }
    
  }
  
}
