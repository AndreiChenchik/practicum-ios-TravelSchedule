//
//  APIService.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol APIServiceProtocol {
  func getAllStations() async throws -> [Station]
}

struct APIService: APIServiceProtocol {
  let client: Client

  func getAllStations() async throws -> [Station] {
    let response = try await client.getStationsList(query: .init())
    let body = try response.ok.body.json

    let stations = body.countries?
      .compactMap(\.regions)
      .flatMap { $0 }
      .compactMap(\.settlements)
      .flatMap { $0 }
      .compactMap(\.stations)
      .flatMap { $0 } ?? []

    return stations.map { Station(title: $0.title ?? "Unknown",
                                  code: $0.codes?.yandex_code ?? "Unknown") }
  }
}
