//
//  ContainerTests.swift
//  ToolBox_Tests
//
//  Created by Berthelot Nicolas on 05/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import ToolBox

class ContainerTests: XCTestCase {

  func testContainer() {
    //Create Int and String container
    var testInt: Int? = TBContainer.getValue(for: "test_1")
    XCTAssert(testInt == nil)
    TBContainer.add(1, for: "test_1")
    testInt = TBContainer.getValue(for: "test_1")
    XCTAssert(testInt == 1)
    
    var testString: String? = TBContainer.getValue(for: "test_1")
    XCTAssert(testString == nil)
    TBContainer.add("Hello world", for: "test_1")
    testString = TBContainer.getValue(for: "test_1")
    XCTAssert(testString == "Hello world")

    //Test collision
    testInt = TBContainer.getValue(for: "test_1")
    XCTAssert(testInt == 1)
    
    //Test Remove
    testInt = TBContainer.removeValue(for: "test_1")
    TBContainer<String>.removeValue(for: "test_1")
    testString = TBContainer.getValue(for: "test_1")
    testInt = TBContainer.getValue(for: "test_1")

    XCTAssert(testString == nil)
    XCTAssert(testInt == nil)
  }
  
}
