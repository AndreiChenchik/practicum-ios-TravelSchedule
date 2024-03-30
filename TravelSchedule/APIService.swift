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
  func getCarrier(code: String) async throws -> Carrier
}

enum APIError: Error {
  case unknown
}

struct APIService: APIServiceProtocol {
  let client: Client

  func getCarrier(code: String) async throws -> Carrier {
    let response = try await client.getCarrier(query: .init(code: code))
    let body = try response.ok.body.json

    guard let firstCarrier = body.carrier else {
      throw APIError.unknown
    }

    return Carrier(code: "\(firstCarrier.code ?? 0)",
                   title: firstCarrier.title ?? "Unknown",
                   address: firstCarrier.address ?? "Unknown")
  }

  func getAllStations() async throws -> [Station] {
    let response = try await client.getStations(query: .init())
    let body = try response.ok.body.json

    let stations = body.countries?
      .compactMap(\.regions).flatMap { $0 }
      .compactMap(\.settlements)
      .flatMap { $0 }
      .compactMap(\.stations)
      .flatMap { $0 } ?? []

    return stations.map {
      let latitude = switch $0.latitude {
      case let .case1(value): "\(value)"
      default: "Unknown"
      }

      let longitude = switch $0.longitude {
      case let .case1(value): "\(value)"
      default: "Unknown"
      }

      let coordinates = latitude + ", " + longitude
      return Station(title: $0.title ?? "Unknown",
                     code: $0.codes?.yandex_code ?? "Unknown",
                     coordinates: coordinates)
    }
  }
}
