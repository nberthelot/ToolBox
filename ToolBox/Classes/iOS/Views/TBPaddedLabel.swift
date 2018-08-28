//
//  TBPaddedLabel.swift
//  ToolBox
//
//  Created by Paride on 11/04/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

open class TBPaddedLabel: UILabel {
  
  public var insets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
  
  override open func drawText(in rect: CGRect) {
    let padding = UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
  }
  
  override open var intrinsicContentSize: CGSize {
    var intrinsicSuperViewContentSize = super.intrinsicContentSize
    intrinsicSuperViewContentSize.height += insets.top + insets.bottom
    intrinsicSuperViewContentSize.width += insets.left + insets.right
    return intrinsicSuperViewContentSize
  }
  
}
