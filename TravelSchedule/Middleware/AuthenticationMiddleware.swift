//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 29.03.24.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

/// Injects an authorization header to every request.
struct AuthenticationMiddleware: ClientMiddleware {
  /// The apiKey value.
  let apiKey: String

  func intercept(
    _ request: HTTPRequest,
    body: HTTPBody?,
    baseURL: URL,
    operationID _: String,
    next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
  ) async throws -> (HTTPResponse, HTTPBody?) {
    var request = request
    request.headerFields[.authorization] = "\(apiKey)"
    return try await next(request, body, baseURL)
  }
}
