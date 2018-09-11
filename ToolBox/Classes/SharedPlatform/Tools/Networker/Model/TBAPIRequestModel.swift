//
//  TBAPIDefinition.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public class TBAPIRequestModel {
  
  weak var service: TBAPISession?
  var parameters: [String: Any]? = nil

  var baseURL: URL? { return nil }
  var path: String? { return nil }
  var method: TBHTTPMethod { return .get }
  var encoding: TBRequestEncoding { return .json }
  var responseEncoding: TBResponseEncoding { return .json }
  var headers: [String: String] { return [String: String]() }
  var canRefreshSession: Bool = true
    
  public init(service: TBAPISession?) {
    self.service = service
  }
  
}
