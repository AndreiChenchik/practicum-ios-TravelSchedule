//
//  ContentView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PreviewItem: Identifiable {
  let id: String
  let title: String
  var description: String?
}

struct PreviewItemView: View {
  let item: PreviewItem
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 0) {
        Text(item.title)

        Spacer()

        Text(item.id)
          .foregroundStyle(.secondary)
      }
      if let description = item.description {
        Text(description)
          .font(.headline)
          .foregroundStyle(.secondary)
      }
    }
  }
}

struct ContentView: View {
  let apiClient: APIServiceProtocol

  @State private var items: [PreviewItem] = []
  @State private var isInFlightRequest = false

  var body: some View {
    Form {
      Section("Status") {
        Text(isInFlightRequest ? "Fetching data..." : "Idle")
      }

      Section("Fetch") {
        Button("Carrier /carrier/") { fetchCarrier() }
        Button("Stations /stations_list/") { fetchStations() }
        Button("Copyright /copyright/") { fetchCopyright() }
      }
      .disabled(isInFlightRequest)

      if !items.isEmpty {
        Section("Fetched") {
          ForEach(items, content: PreviewItemView.init)
        }
      }
    }
  }
}

private extension ContentView {
  func fetchCarrier() {
    isInFlightRequest = true
    items = []

    Task {
      do {
        let carrier = try await apiClient.getCarrier(code: "680")
        items = [PreviewItem(id: carrier.code, title: carrier.title, description: carrier.address)]
      } catch {
        print(error)
      }

      isInFlightRequest = false
    }
  }

  func fetchStations() {
    isInFlightRequest = true
    items = []

    Task {
      do {
        let stations = try await apiClient.getAllStations()
        items = stations.map { PreviewItem(id: $0.code,
                                           title: $0.title,
                                           description: $0.coordinates) }
      } catch {
        print(error)
      }

      isInFlightRequest = false
    }
  }

  func fetchCopyright() {
    fetchStations()
  }
}

#if DEBUG
  struct PreviewClient: APIServiceProtocol {
    func getCarrier(code: String) async throws -> Carrier {
      Carrier(code: "680", title: "РЖД", address: "Moscow")
    }

    func getAllStations() async throws -> [Station] {
      try await Task.sleep(nanoseconds: 500_000_000)

      return [
        Station(title: "London",
                code: "LON",
                coordinates: "51.5074° N, 0.1278° W"),
        Station(title: "Paris",
                code: "PAR",
                coordinates: "48.8566° N, 2.3522° E"),
        Station(title: "Berlin",
                code: "BER",
                coordinates: "52.5200° N, 13.4050° E"),
      ]
    }
  }

  #Preview {
    ContentView(apiClient: PreviewClient())
  }

#endif
