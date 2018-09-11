//
//  TBAPIDefinition.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

open class TBAPIRequestModel {
  
  weak var service: TBAPISession?
  open var parameters: [String: Any]? = nil

  open var baseURL: URL? { return nil }
  open var path: String? { return nil }
  open var method: TBHTTPMethod { return .get }
  open var encoding: TBRequestEncoding { return .json }
  open var responseEncoding: TBResponseEncoding { return .json }
  open var headers: [String: String] { return [String: String]() }
  open var canRefreshSession: Bool = true
    
  public init(service: TBAPISession?) {
    self.service = service
  }
  
}
