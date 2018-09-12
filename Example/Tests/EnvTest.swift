//
//  EnvTest.swift
//  ToolBox_Tests
//
//  Created by Berthelot Nicolas on 12/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import ToolBox

class EnvTest: XCTestCase {
  
    func testEnv() {
      let baseURLEnv = TBEnvironmentValues((.dev, URL(string: "www.dev.com")!),
                                           (.prod, URL(string: "www.prod.com")!) )
      XCTAssert(baseURLEnv.value(for: .dev) != nil)
      XCTAssert(baseURLEnv.value(for: .prod) != nil)
      XCTAssert(baseURLEnv.value(for: .staging) == nil)
      XCTAssert(baseURLEnv.unwrappedValue(for: .dev).absoluteString == "www.dev.com")
      XCTAssert(baseURLEnv.unwrappedValue(for: .prod).absoluteString == "www.prod.com")
    }
    
}
