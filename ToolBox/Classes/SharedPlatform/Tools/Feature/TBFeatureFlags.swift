//
//  TBFeaturesFlag.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 04/07/2018.
//

import Foundation

extension NSNotification.Name {
  public static let TBFeatureFlagsDidChange = NSNotification.Name("TBFeatureFlagsDidChange")
}

public struct TBFeatureFlags {
  
  private static var enabledFeatureFlags = [TBFeatureFlag.Name: Bool]()
  
  public static func isEnabled(_ name: TBFeatureFlag.Name) -> Bool {
    return enabledFeatureFlags[name] ?? false
  }
  
  public static func set(_ name: TBFeatureFlag.Name, enabled: Bool) {
    let oldValue = enabledFeatureFlags[name]
    if oldValue == nil && enabled == false {
      enabledFeatureFlags[name] = false
      return
    }
    if oldValue != enabled {
      enabledFeatureFlags[name] = enabled
      let newValue = TBFeatureFlag(name: name, enabled: enabled)
      NotificationCenter.default.post(name: .TBFeatureFlagsDidChange, object: [newValue])
    }
  }
  
  public static func setFeature(_ flags: [(name: TBFeatureFlag.Name, enabled: Bool)]) {
    var features = [TBFeatureFlag]()
    flags.forEach {
      let oldValue = isEnabled($0.name)
      if oldValue != $0.enabled {
        enabledFeatureFlags[$0.name] =  $0.enabled
        features.append(TBFeatureFlag(name: $0.name, enabled: $0.enabled))
      }
    }
    if features.isEmpty == false {
      NotificationCenter.default.post(name: .TBFeatureFlagsDidChange, object: features)
    }
  }
  
  public static func feature(_ name: TBFeatureFlag.Name, matchNotification notif: Notification) -> Bool {
    guard let features = notif.object as? [TBFeatureFlag] else { return  false }
    for feature in features {
      if feature.name == name { return true }
    }
    return false
  }
  
  public static func getFeature(_ name: TBFeatureFlag.Name, inNotification notif: Notification) -> TBFeatureFlag? {
    guard let features = notif.object as? [TBFeatureFlag] else { return nil }
    for feature in features {
      if feature.name == name { return feature }
    }
    return nil
  }
  
  public static func features(_ names: [TBFeatureFlag.Name], matchNotification notif: Notification) -> Bool {
    for name in names {
      if feature(name, matchNotification: notif) { return true }
    }
    return false
  }

  public static func getAllFeatures() -> [TBFeatureFlag] {
    var features = [TBFeatureFlag]()
    enabledFeatureFlags.forEach {
      features.append(TBFeatureFlag(name: $0.key, enabled: $0.value))
    }
    return features
  }
  
}

