//
//  SFSafariViewController+Routable.swift
//  ToolBox
//
//  Created by Lory Huz on 07/12/2018.
//

import Foundation
import SafariServices

@available(iOS 9.0, *)
extension SFSafariViewController: TBRoutable {}

public extension TBRoutable where Self: SFSafariViewController {
  
  static func loadController(with data: Any?, for route: String) -> UIViewController? {
    if let url = data as? URL ?? URL(string: data as? String ?? "") {
      return SFSafariViewController(url: url)
    }
    
    return nil
  }
  
}
