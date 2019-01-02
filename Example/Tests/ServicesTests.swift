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

protocol ServiceUserProtocol: TBServiceProtocol {
  var name: String { get }
}

protocol ServiceSocialProtocol: TBServiceProtocol {
  var userName: String { get }
}

// SERVICES
final class ServiceUser: TBBaseService, ServiceUserProtocol {
  var name: String { return "nicolas" }
}

final class ServiceUser2: TBBaseService, ServiceUserProtocol {
  var name: String = ""
  
  required init() {
    super.init()
    self.name = "tom"
  }
  
}

final class ServiceSocial: TBBaseService, ServiceSocialProtocol {
  var userName: String {
    return retrieveService(type: ServiceUserProtocol.self).name
  }
}

final class Service1: TBBaseService, ServiceTestProtocol {
  var value: Int { return 1 }
}

final class Service2: TBBaseService, ServiceTestProtocol {
  var value: Int { return 2 }
}

class ServicesTests: XCTestCase {

  func testService() {
    TBServices.add(Service1.self, for: ServiceTestProtocol.self)
    XCTAssert(TBServices.retrieve(type: ServiceTestProtocol.self).value == 1)
    TBServices.add(Service2.self, for: ServiceTestProtocol.self)
    XCTAssert(TBServices.retrieve(type: ServiceTestProtocol.self).value == 2)
    
    TBServices.add(ServiceUser2.self, for: ServiceUserProtocol.self)
    TBServices.add(ServiceUser.self,  for: ServiceUserProtocol.self, dependencies: nil)
    
    TBServices.add(ServiceSocial.self,
                   for: ServiceSocialProtocol.self,
                   dependencies: [(protocol: ServiceUserProtocol.self, serviceType: ServiceUser2.self)])
    
    XCTAssert(TBServices.retrieve(type: ServiceSocialProtocol.self).userName == "tom")
    XCTAssert(TBServices.retrieve(type: ServiceUserProtocol.self).name == "nicolas")
  }
  
}
