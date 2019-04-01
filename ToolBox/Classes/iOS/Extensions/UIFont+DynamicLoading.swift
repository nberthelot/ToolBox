//
//  UIFont+DynamicLoading.swift
//  ToolBox
//
//  Created by Paride on 02/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

public enum RLFontsError: Error {
  case dynamicLoading
}

public extension UIFont {
  
  static func x_register(from url: URL) throws {
    guard let fontDataProvider = CGDataProvider(url: url as CFURL), let font = CGFont(fontDataProvider) else {
      throw RLFontsError.dynamicLoading
    }
    var error: Unmanaged<CFError>?
    
    guard CTFontManagerRegisterGraphicsFont(font, &error) else {
      throw error!.takeUnretainedValue()
    }
  }
  
}
