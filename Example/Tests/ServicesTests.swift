//
//  ServicesTests.swift
//  ToolBox_Tests
//
//  Created by Berthelot Nicolas on 05/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import ToolBox

protocol ServiceTestProtocol: TBServiceProtocol {
  var value : Int { get }
}

final class Service1: ServiceTestProtocol {
  var value: Int { return 1 }
  static func loadService() -> Service1 { return Service1() }
}

final class Service2: ServiceTestProtocol {
  var value: Int { return 2 }
  static func loadService() -> Service2 { return Service2() }
}

class ServicesTests: XCTestCase {

  func testService() {
    TBServices.add(Service1.self, for: ServiceTestProtocol.self)
    XCTAssert(TBServices.retrieve(type: ServiceTestProtocol.self).value == 1)
    TBServices.add(Service2.self, for: ServiceTestProtocol.self)
    XCTAssert(TBServices.retrieve(type: ServiceTestProtocol.self).value == 2)
  }
  
}
