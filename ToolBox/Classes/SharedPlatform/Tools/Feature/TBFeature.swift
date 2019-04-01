//
//  TBFeature.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 05/07/2018.
//

import Foundation

extension NSNotification.Name {
  public static let tbFeaturesDidChange = NSNotification.Name("tbFeaturesDidChange")
}

public struct TBFeature {
  
  public let name: TBFeature.Name
  public let enabled: Bool
  
  init(name: TBFeature.Name, enabled: Bool) {
    self.name = name
    self.enabled = enabled
  }
  
}

// MARK: - FEATURES MANAGEMENT
extension TBFeature {
  
  private static var enabledFeatures = [TBFeature.Name: Bool]()
  
  public static func isEnabled(_ name: TBFeature.Name) -> Bool {
    return enabledFeatures[name] ?? false
  }
  
  public static func set(_ name: TBFeature.Name, enabled: Bool) {
    let oldValue = enabledFeatures[name]
    if oldValue == nil && enabled == false {
      enabledFeatures[name] = false
      return
    }
    if oldValue != enabled {
      enabledFeatures[name] = enabled
      let newValue = TBFeature(name: name, enabled: enabled)
      NotificationCenter.default.post(name: .tbFeaturesDidChange, object: [newValue])
    }
  }
  
  public static func setFeatures(_ flags: [(name: TBFeature.Name, enabled: Bool)]) {
    var features = [TBFeature]()
    flags.forEach {
      let oldValue = isEnabled($0.name)
      if oldValue != $0.enabled {
        enabledFeatures[$0.name] =  $0.enabled
        features.append(TBFeature(name: $0.name, enabled: $0.enabled))
      }
    }
    if features.isEmpty == false {
      NotificationCenter.default.post(name: .tbFeaturesDidChange, object: features)
    }
  }
  
  public static func feature(_ name: TBFeature.Name, matchNotification notif: Notification) -> Bool {
    guard let features = notif.object as? [TBFeature] else { return  false }
    for feature in features {
      if feature.name == name { return true }
    }
    return false
  }
  
  public static func getFeature(_ name: TBFeature.Name, inNotification notif: Notification) -> TBFeature? {
    guard let features = notif.object as? [TBFeature] else { return nil }
    for feature in features {
      if feature.name == name { return feature }
    }
    return nil
  }
  
  public static func getAllFeatures() -> [TBFeature] {
    var features = [TBFeature]()
    enabledFeatures.forEach {
      features.append(TBFeature(name: $0.key, enabled: $0.value))
    }
    return features
  }
  
}

