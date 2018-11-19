//
//  Encoding.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public enum TBRequestEncoding {
  case `default`
  case json
  case queryString
}

public enum TBResponseEncoding {
  case `default`
  case json
  case data
  case string
}

public enum TBHTTPMethod: String {
  case options = "OPTIONS"
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
  case trace   = "TRACE"
  case connect = "CONNECT"
}

public enum TBAuthorizationType {
  case jwt(value: String)
  case oauth(value: String)

  var value: String {
    switch(self) {
    case .jwt(let value): return "JWT \(value)"
    case .oauth(let value): return "Bearer \(value)"
    }
  }
  
}

public enum TBHeaderKeys {
  static let authorization: String  = "Authorization"
  static let userAgent: String      = "User-Agent"
}
