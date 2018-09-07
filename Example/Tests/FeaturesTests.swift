//
//  FeaturesTests.swift
//  ToolBox_Tests
//
//  Created by Berthelot Nicolas on 04/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import ToolBox

extension TBFeature.Name {
  public static let foo = TBFeature.Name("foo")
  public static let bar = TBFeature.Name("bar")
}

class FeaturesTests: XCTestCase {
  
  func testFeatures() {
    // SET Test
    XCTAssertFalse(TBFeature.isEnabled(.foo))
    
    TBFeature.set(.foo, enabled: true)
    XCTAssertTrue(TBFeature.isEnabled(.foo))
    
    TBFeature.set(.foo, enabled: false)
    XCTAssertFalse(TBFeature.isEnabled(.foo))

    XCTAssert(TBFeature.getAllFeatures().count == 1)
    
    TBFeature.setFeatures([(.foo, true), (.bar, true)])
    XCTAssertTrue(TBFeature.isEnabled(.foo))
    XCTAssertTrue(TBFeature.isEnabled(.bar))

    TBFeature.setFeatures([(.foo, false), (.bar, true)])
    XCTAssertFalse(TBFeature.isEnabled(.foo))
    XCTAssertTrue(TBFeature.isEnabled(.bar))
    
    // NOTIF TESTS
    let featureNotificationExpectation = expectation(description: "featureNotificationExpectation")
    NotificationCenter.default.addObserver(forName: .tbFeaturesDidChange, object: nil, queue: .main) { (notif) in
      XCTAssertTrue(TBFeature.feature(.foo, matchNotification: notif))
      let feature = TBFeature.getFeature(.foo, inNotification: notif)
      XCTAssert(feature != nil)
      XCTAssert(feature!.name == .foo)
      featureNotificationExpectation.fulfill()
    }
    TBFeature.set(.foo, enabled: true)
    waitForExpectations(timeout: 3, handler: nil)
    NotificationCenter.default.removeObserver(self)
  }
  
}
