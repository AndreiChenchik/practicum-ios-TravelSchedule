//
//  ContentView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import SwiftUI

struct ContentView: View {
  let apiClient: APIServiceProtocol

  @State private var items: [(id: String, title: String)] = []
  @State private var isInFlightRequest = false

  var body: some View {
    Form {
      Section("Available endpoints") {
        Button("Fetch stations") { fetchStations() }
      }
      .disabled(isInFlightRequest)

      if isInFlightRequest {
        ProgressView()
      }

      if !items.isEmpty {
        Section("Fetched") {
          ForEach(items, id: \.id) { item in
            Text("\(item.title), \(item.id)")
          }
        }
      }
    }
  }

  func fetchStations() {
    isInFlightRequest = true
    items = []

    Task {
      do {
        let stations = try await apiClient.getAllStations()
        items = stations.map { (id: $0.code, title: $0.title) }
      } catch {
        print(error)
      }

      isInFlightRequest = false
    }
  }
}

#if DEBUG
  struct PreviewClient: APIServiceProtocol {
    func getAllStations() async throws -> [Station] {
      try await Task.sleep(nanoseconds: 1 * 1_000_000_000)

      return [
        Station(title: "London", code: "LON"),
        Station(title: "Paris", code: "PAR"),
        Station(title: "Berlin", code: "BER"),
      ]
    }
  }

  #Preview {
    ContentView(apiClient: PreviewClient())
  }

#endif
