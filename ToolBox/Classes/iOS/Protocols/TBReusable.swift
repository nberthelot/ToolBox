//
//  TBReusable.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 26/10/2017.
//

import Foundation

public protocol TBReusable: TBNibLoadable {
  static var reuseIdentifier: String { get }
  static var nib: UINib? { get }
}

public extension TBReusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  static var nib: UINib? {
    return UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
  }
  
}
