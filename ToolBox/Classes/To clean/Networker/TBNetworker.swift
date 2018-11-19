//
//  TBNetworker.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation
import Alamofire

public class TBNetworker {
  
  public static var instance = TBNetworker()

  var configuration = TBNetworkerConfiguration()
  
  private init() { }

  public static func execute<T: TBAPIModelProtocol>(request: TBAPIRequestModel, completionHandler: @escaping (T?, Error?) -> Void) {
    guard let httpRequest = self.createHTTPRequest(for: request) else {
      completionHandler(nil, TBNetworkerError.invalidRequest)
      return
    }
    httpRequest.responseJSON { response in
      self.computeResponse(request: request, response: response, completionHandler: completionHandler)
    }
  }
  
  /**
   * Creates Alamofire's request according a request
   * /!\ Dependency with 'Alamofire'
   */
  private static func createHTTPRequest(for apiDef: TBAPIRequestModel) -> DataRequest? {
    guard let requestUrl: URL = self.constructBaseUrl(from: apiDef) else { return nil }
    guard let headers: [String: String] = self.constructHeaders(from: apiDef) else { return nil }
    return Alamofire.request(requestUrl,
                             method: apiDef.method.alamofire,
                             parameters: apiDef.parameters,
                             encoding: apiDef.encoding.alamofire,
                             headers: headers)
                    .validate(statusCode: 200..<300)
  }
  
  
  // MARK: - Services - Response
  
  private static func computeResponse<Value, T: TBAPIModelProtocol>(request: TBAPIRequestModel, response: DataResponse<Value>, completionHandler: @escaping (T?, Error?) -> Void) {
    // Manage Authorization - 401
    if let httpResponse = response.response, httpResponse.statusCode == 401, let delegate = request.service?.delegate {
      if request.canRefreshSession {
        delegate.refreshSession { (success, error) in
          if success {
            TBNetworker.execute(request: request, completionHandler: completionHandler)
          } else {
            completionHandler(nil, error)
          }
        }
        return
      }
    }
    
    // Manage result
    switch(response.result) {
    case .success:
      if let value = response.value, let object = T.init(fromApi: value) {
        completionHandler(object, nil)
      } else {
        completionHandler(nil, TBNetworkerError.responseParsing)
      }
    case .failure(let error):
      if let session = request.service {
        let statusCode: Int? = response.response?.statusCode
        let body: Any? = response.data
        let errors = session.computeErrors(statusCode: statusCode, body: body, defaultError: error)
        completionHandler(nil, errors.first)
      } else {
        completionHandler(nil, error)
      }
    }
  }
  
}

// MARK: - Utils
extension TBNetworker {
  
  private static func constructBaseUrl(from request: TBAPIRequestModel) -> URL? {
    var urlString: String = ""
    if let baseUrl = request.service?.configuration.baseUrl.absoluteString {
      urlString += baseUrl
    }
    if let sessionPath = request.path {
      urlString += sessionPath
    }
    return URL(string: urlString)
  }
  
  private static func constructHeaders(from request: TBAPIRequestModel) -> [String: String]? {
    var headers: [String: String] = [:]
    if let serviceHeaders = request.service?.configuration.headers, serviceHeaders.isEmpty == false {
      headers.x_merge(with: serviceHeaders)
    }
    let requestHeaders = request.headers
    headers.x_merge(with: requestHeaders)
    return headers
  }
  
}
