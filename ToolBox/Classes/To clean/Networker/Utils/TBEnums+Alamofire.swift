//
//  Enums+Alamofire.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation
import Alamofire

// MARK: - ALAMOFIRE BRIDGE
extension TBHTTPMethod {
  
  var alamofire: Alamofire.HTTPMethod {
    switch self {
    case .options:  return .options
    case .get:      return .get
    case .head:     return .head
    case .post:     return .post
    case .put:      return .put
    case .patch:    return .patch
    case .delete:   return .delete
    case .trace:    return .trace
    case .connect:  return .connect
    }
  }
  
}

extension TBRequestEncoding {
  
  var alamofire: Alamofire.ParameterEncoding {
    switch self {
    case .json:         return JSONEncoding.default
    case .queryString:  return URLEncoding.default
    default:            return JSONEncoding.default
    }
  }
  
}
