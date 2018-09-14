//
//  TBEnvironmentSettings.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 13/09/2018.
//

import Foundation

public extension NSNotification.Name {
  static let tbEnvironmentSettingsDidChange = NSNotification.Name("TBEnvironmentSettingsDidChange")
}

public struct TBEnvironmentSettings {
  
  private static var environmentSettingsValue  = [TBEnvironmentSettings.Key: Any]()

  public static var environment: TBEnvironment = .prod {
    didSet {
      NotificationCenter.default.post(name: .tbEnvironmentSettingsDidChange, object: environment)
    }
  }
  
  public static func set<T>(_ values : TBEnvironmentValues<T>, for key: TBEnvironmentSettings.Key) {
    environmentSettingsValue[key] = values
  }
  
  public static func getEnvValue<T>(for key: TBEnvironmentSettings.Key) -> T? {
    return (environmentSettingsValue[key] as? TBEnvironmentValues<T>)?.value(for: environment)
  }
  
  public static func getUnwrappedEnvValue<T>(for key: TBEnvironmentSettings.Key) -> T {
    return getEnvValue(for: key)!
  }
  
  public static func remove(key: TBEnvironmentSettings.Key) {
    environmentSettingsValue.removeValue(forKey: key)
  }

}

public extension TBEnvironmentSettings {
  
  public struct Key: Hashable, Equatable, RawRepresentable {
    
    public var rawValue: String
    
    public init?(rawValue: String) {
      self.rawValue = rawValue
    }
    
    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }
  }

}
