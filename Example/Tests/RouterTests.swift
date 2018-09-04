//
//  RouterTests.swift
//  ToolBox_Tests
//
//  Created by Berthelot Nicolas on 04/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import ToolBox

class TestRouteViewController1: UIViewController, TBRoutable {
  public static func loadController(with data: Any?, for route: String) -> UIViewController? {
    return self.init()
  }
}

class TestRouteViewController2: UIViewController, TBRoutable {
  public static func loadController(with data: Any?, for route: String) -> UIViewController? {
    return self.init()
  }
}


class RouterTests: XCTestCase {
  
  func testRouter() {
    if let url = Bundle.main.url(forResource: "Routes", withExtension: "json") {
      TBRouter.loadRoutes(from: url)
    }
    else {
      XCTFail()
    }
    XCTAssert(TBRouter.route("testRouteViewController1", with: nil) is TestRouteViewController1)
    XCTAssert(TBRouter.route("testRouteViewController2", with: nil) == nil)
    
    TBRouter.addRoute("testRouteViewController2", routableClass: TestRouteViewController2.self)
    XCTAssert(TBRouter.route("testRouteViewController1", with: nil) is TestRouteViewController1)
    XCTAssert(TBRouter.route("testRouteViewController2", with: nil) is TestRouteViewController2)
    
    TBRouter.remove("testRouteViewController2")
    TBRouter.addRoute("testRouteViewController2", routableClass: TestRouteViewController2.self)
  }
  
}
