//
//  TBNibLoadable.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 26/10/2017.
//

import Foundation

public protocol TBNibLoadable: class {
  static var nibIdentifier: String { get }
  static var bundle: Bundle? { get }
}

public extension TBNibLoadable {
  static var nibIdentifier: String {
    return String(describing: self)
  }
  static var bundle: Bundle? {
    return Bundle(for: self)
  }
}

public extension TBNibLoadable {
  
  public static func x_loadFromNib(_ owner: NSObject? = nil, options: [AnyHashable : Any]? = nil) -> Self? {
    let bundle = Bundle(for: self)
    let nibIdentifier = String(describing: self)
    let view = bundle.loadNibNamed(nibIdentifier, owner: owner, options: options)?.first as? Self
    return view
  }
  
}
