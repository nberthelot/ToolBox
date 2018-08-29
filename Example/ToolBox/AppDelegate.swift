//
//  AppDelegate.swift
//  ToolBox
//
//  Created by Berthelot nicolas on 08/28/2018.
//  Copyright (c) 2018 Berthelot nicolas. All rights reserved.
//

import UIKit
import ToolBox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if let url = Bundle.main.url(forResource: "Routes", withExtension: "json") {
      TBRouter.loadRoutes(from: url)
    }
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

