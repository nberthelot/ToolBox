//
//  UITableView+Reusable.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 07/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import UIKit


public extension UITableView {
  
  func x_register(reusableCell reusable: TBReusable.Type) {
    if let nib = reusable.nib {
      self.register(nib, forCellReuseIdentifier: reusable.reuseIdentifier)
    }
    else {
      self.register(reusable.self, forCellReuseIdentifier: reusable.reuseIdentifier)
    }
  }
  
  func x_register(reusableCell reusable: TBReusable.Type, forHeaderFooterViewReuseIdentifier: String) {
    if let nib = reusable.nib {
      self.register(nib, forHeaderFooterViewReuseIdentifier: reusable.reuseIdentifier)
    }
    else {
      self.register(reusable.self, forHeaderFooterViewReuseIdentifier: reusable.reuseIdentifier)
    }
  }
  
  func x_registerReusableCell<T: UITableViewCell>(_: T.Type) where T: TBReusable {
    if let nib = T.nib {
      self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    else {
      self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
  }
    
  func x_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: TBReusable {
    return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
  
  func x_registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: TBReusable {
    if let nib = T.nib {
      self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    else {
      self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
  }
  
  func x_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: TBReusable {
    return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
  }
  
}
