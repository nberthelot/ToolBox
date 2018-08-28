//
//  UICollectionView+Reusable.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 07/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import UIKit


public extension UICollectionView {
  
  func x_register(reusableCell reusable: TBReusable.Type) {
    if let nib = reusable.nib {
      self.register(nib, forCellWithReuseIdentifier: reusable.reuseIdentifier)
    }
    else {
      self.register(reusable.self, forCellWithReuseIdentifier: reusable.reuseIdentifier)
    }
  }
  
  func x_register(reusableSupplementaryView reusable: TBReusable.Type, elementKind: String) {
    if let nib = reusable.nib {
      self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reusable.reuseIdentifier)
    }
    else {
      self.register(reusable.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reusable.reuseIdentifier)
    }
  }
  
  func x_dequeue(reusableSupplementaryView reusable: TBReusable.Type, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView {
    return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: reusable.reuseIdentifier, for: indexPath)
  }
  
  func x_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: TBReusable {
    return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
  
  func x_dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T where T: TBReusable {
    return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
  
}

