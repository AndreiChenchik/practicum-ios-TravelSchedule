//
//  APIService.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol APIServiceProtocol {
  func getThreads(from: String, to: String) async throws -> [Thread]
  func getSchedule(station: String) async throws -> [Thread]
  func getThread(uid: String) async throws -> [Station]
  func getNearestStations(latitude: Float, longitude: Float) async throws -> [Station]
  func getNearestSettlement(latitude: Float, longitude: Float) async throws -> Settlement
  func getAllStations() async throws -> [Station]
  func getCarrier(code: String) async throws -> Carrier
  func getCopyright() async throws -> String
}

enum APIError: Error {
  case unknown
}

struct APIService: APIServiceProtocol {
  let client: Client

  func getThreads(from: String, to: String) async throws -> [Thread] {
    let response = try await client.getSearch(query: .init(from: from, to: to))
    let body = try response.ok.body.json
    return body.search?.interval_segments?.compactMap {
      Thread(uid: $0.thread?.uid ?? "Unknown",
             title: $0.thread?.title ?? "Unknown",
             days: $0.departure_terminal ?? "Unknown")
    } ?? []
  }

  func getSchedule(station: String) async throws -> [Thread] {
    let response = try await client.getSchedule(query: .init(station: station))
    let body = try response.ok.body.json

    return body.schedule?.compactMap {
      Thread(uid: $0.thread?.uid ?? "Unknown",
             title: $0.thread?.title ?? "Unknown",
             days: $0.days ?? "Unknown")
    } ?? []
  }

  func getThread(uid: String) async throws -> [Station] {
    let response = try await client.getThread(query: .init(uid: uid))
    let body = try response.ok.body.json

    return body.stops?.compactMap {
      let latitude = switch $0.station?.latitude {
      case let .case1(value): "\(value)"
      default: "Unknown"
      }

      let longitude = switch $0.station?.longitude {
      case let .case1(value): "\(value)"
      default: "Unknown"
      }

      return Station(title: $0.station?.title ?? "Unknown",
                     code: $0.station?.code ?? "Unknown",
                     coordinates: "\(latitude), \(longitude)")
    } ?? []
  }

  func getNearestStations(latitude: Float, longitude: Float) async throws -> [Station] {
    let response = try await client.getNearestStations(
      query: .init(lat: latitude, lng: longitude, distance: 50)
    )
    let body = try response.ok.body.json

    return body.stations!.map {
      Station(title: $0.title ?? "Unknown",
              code: $0.code ?? "Unknown",
              coordinates: "\($0.lat ?? 999), \($0.lng ?? 999)")
    }
  }

  func getNearestSettlement(latitude: Float, longitude: Float) async throws -> Settlement {
    let response = try await client.getNearestSettlement(
      query: .init(lat: latitude, lng: longitude)
    )
    let body = try response.ok.body.json

    return Settlement(title: body.title, latitude: body.lat, longitude: body.lng)
  }

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

  func getCopyright() async throws -> String {
    let response = try await client.getCopyright()
    let body = try response.ok.body.json

    return body.copyright?.text ?? "Unknown"
  }
}
