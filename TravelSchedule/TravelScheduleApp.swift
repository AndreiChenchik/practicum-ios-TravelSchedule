//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import SwiftUI

import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
  let apiClient: APIServiceProtocol = {
    let authenticationMiddleware = AuthenticationMiddleware(
      apiKey: "c2c6e426-a5d4-4cb6-973d-098880865da2"
    )
    let stationsListFixMiddleware = StationsListFixMiddleware()

    let client = try! Client(
      serverURL: Servers.server1(),
      transport: URLSessionTransport(),
      middlewares: [authenticationMiddleware, stationsListFixMiddleware]
    )

    return APIService(client: client)
  }()

  var body: some Scene {
    WindowGroup {
      ContentView(apiClient: apiClient)
    }
  }
}
