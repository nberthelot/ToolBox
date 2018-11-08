//
//  TBService.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 31/10/2017.
//

import Foundation

public protocol TBServiceProtocol {
  static func loadService(dependencies: DependencyInjectionSequence?) -> Self
  init()
}
