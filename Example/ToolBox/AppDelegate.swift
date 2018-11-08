//
//  AppDelegate.swift
//  ToolBox
//
//  Created by Berthelot nicolas on 08/28/2018.
//  Copyright (c) 2018 Berthelot nicolas. All rights reserved.
//

import UIKit
import ToolBox

// MARK: PROTOCOL
protocol ServiceUserProtocol: TBServiceProtocol {
  var name: String { get }
}

protocol ServiceSocialProtocol: TBServiceProtocol {
  var userName: String { get }
}


// SERVICES
final class ServiceUser: TBBaseService, ServiceUserProtocol {
  var name: String = "Nicolas"
}

final class ServiceUser2: TBBaseService, ServiceUserProtocol {
  var name: String = "tom"
}

final class ServiceSocial: TBBaseService, ServiceSocialProtocol {
  var userName: String {
    return retrieveService(type: ServiceUserProtocol.self).name
  }
  
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let url = Bundle.main.url(forResource: "Routes", withExtension: "json") {
      TBRouter.loadRoutes(from: url)
    }
    
    TBServices.add(ServiceUser.self,  for: ServiceUserProtocol.self, dependencies: nil)
    TBServices.add(ServiceUser2.self, for: ServiceUserProtocol.self, priority: .low)

    TBServices.add(ServiceSocial.self,
                   for: ServiceSocialProtocol.self,
                   dependencies: [(protocol: ServiceUserProtocol.self, serviceType: ServiceUser2.self)])

    print(TBServices.retrieve(type: ServiceSocialProtocol.self).userName) // => TOM (UserServiceService 2)
    print(TBServices.retrieve(type: ServiceUserProtocol.self).name) // NIcolas (serviceUser1
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    
  }
  
}

