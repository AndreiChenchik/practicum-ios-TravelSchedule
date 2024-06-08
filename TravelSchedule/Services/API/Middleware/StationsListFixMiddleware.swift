//
//  StationsListFixMiddleware.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 29.03.24.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

/// Injects an authorization header to every request.
struct StationsListFixMiddleware: ClientMiddleware {
  func intercept(
    _ request: HTTPRequest,
    body: HTTPBody?,
    baseURL: URL,
    operationID _: String,
    next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
  ) async throws -> (HTTPResponse, HTTPBody?) {
    var (response, body) = try await next(request, body, baseURL)

    let contentType = response.headerFields[.contentType]

    if request.path == "/stations_list/", contentType == "text/html; charset=utf-8" {
      response.headerFields[.contentType] = "application/json"
    }

    return (response, body)
  }
}
