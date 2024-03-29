//
//  ContentView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
  let apiClient: APIServiceProtocol

  @State private var items: [(id: String, title: String)] = []
  @State private var isInFlightRequest = false
  @State private var stationCode = ""

  var body: some View {
    Form {
      Section("Status") {
        Text(isInFlightRequest ? "Fetching data..." : "Idle")
      }

      Section {
        Button("Fetch stations") { fetchStations() }
      }
      .disabled(isInFlightRequest)

      Section {
        Text(stationCode.isEmpty ? "Tap on fetched object to select" : stationCode)
          .opacity(stationCode.isEmpty ? 0.25 : 1)

        Button("Fetch routes") {}
        Button("Fetch routes") {}
      }
      .disabled(isInFlightRequest || stationCode.isEmpty)

      if !items.isEmpty {
        Section("Fetched") {
          ForEach(items, id: \.id) { item in
            Button {
              stationCode = item.id
            } label: {
              Text("\(item.title), \(item.id)")
            }
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
