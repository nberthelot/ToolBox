//
//  TBPagerViewTransformer.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 25/08/2017.
//  Copyright © 2017 Nicolas Berthelot. All rights reserved.
//

import Foundation
import UIKit

open class TBPagerViewTransformer {
  
  public init() {
    
  }
  
  open func applyTransform(_ view: UIView, progress: CGFloat, fromPager pager: TBPagerView, animated: Bool, duration: TimeInterval = 0) {
    let translationTransform = CATransform3DMakeTranslation(view.frame.width * progress, 0, 0)
    if animated == true && (view.frame.origin.x <= 0 && progress <= 0 || view.frame.origin.x >= 0 && progress >= 0) {
      UIView.animate(withDuration: duration, animations: {
        view.layer.transform = translationTransform
      }) { _ in
      }
    }
    else {
      view.layer.transform = translationTransform
    }
  }
  
}
