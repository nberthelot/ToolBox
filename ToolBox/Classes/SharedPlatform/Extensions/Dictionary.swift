//
//  Dictionary+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 07/12/2018.
//

import Foundation


extension Dictionary {
  
  public static func x_load(from url: URL, asynchronous: Bool = false, completion: @escaping ([Key: Value]?) -> ())  {
    let deserialize: () -> ([Key: Value]?) = {
      if url.pathExtension == "plist" {
        return NSDictionary(contentsOf: url) as? [Key: Value]
      }
      else {
        guard let data = try? Data(contentsOf: url),
          let json = try? JSONSerialization.jsonObject(with: data) else {
            return nil
        }
        return json as? [Key: Value]
      }
    }
    
    if asynchronous == false {
      completion(deserialize())
    }
    else {
      DispatchQueue.global(qos: .background).async {
        let data = deserialize()
        DispatchQueue.main.async {
          completion(data)
        }
      }
    }
  }
  
}
