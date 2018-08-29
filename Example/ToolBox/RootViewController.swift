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
    return Example.count.rawValue
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ExampleTitleTableViewCell = tableView.x_dequeueReusableCell(indexPath: indexPath)
    cell.configure(with: Example.init(rawValue: indexPath.row)?.name)
    return cell
  }
  
}

//MARK: UITABLEVIEWDELEGATE
extension RootViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    x_performRoute("/tabbar", presentationType: .modal)
  }
  
}

extension RootViewController {
  
  enum Example: Int {
    
    case tabbar = 0
    
    case count

    var name: String {
      switch self {
      case .tabbar: return "Tabbar"
      case .count: return "count"
      }
    }
    
  }
  
}
