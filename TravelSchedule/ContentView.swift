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
    VStack(alignment: .leading) {
      HStack(spacing: 0) {
        Text(item.title)

        Spacer()

        Text(item.id)
          .foregroundStyle(.secondary)
      }
      if let description = item.description {
        Text(description)
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
        VStack(alignment: .leading) {
          Button("Stations /nearest_stations/") { fetchNearesStations() }
          Text("Ближайшие станции к координатам 59.945223, 30.365061")
            .foregroundStyle(.secondary)
        }

        VStack(alignment: .leading) {
          Button("Settlement /nearest_settlement/") { fetchNearbySettlement() }
          Text("Ближайший город к координатам 59.945223, 30.365061")
            .foregroundStyle(.secondary)
        }

        VStack(alignment: .leading) {
          Button("Carrier /carrier/") { fetchCarrier() }
          Text("Загрузит информацию о перевозчике с кодом 680")
            .foregroundStyle(.secondary)
        }

        VStack(alignment: .leading) {
          Button("Stations /stations_list/") { fetchStations() }
          Text("Загрузит список всех станций")
            .foregroundStyle(.secondary)
        }

        VStack(alignment: .leading) {
          Button("Copyright /copyright/") { fetchCopyright() }
          Text("Загрузит информацию о копирайте")
            .foregroundStyle(.secondary)
        }
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
  func fetch(_ perform: @escaping () async throws -> [PreviewItem]) {
    isInFlightRequest = true
    items = []

    Task {
      do {
        items = try await perform()
      } catch {
        print(error)
      }

      isInFlightRequest = false
    }
  }

  func fetchNearesStations() {
    fetch {
      let stations = try await apiClient.getNearestStations(latitude: 59.945223,
                                                            longitude: 30.365061)
      return stations.map { PreviewItem(id: $0.code, title: $0.title, description: $0.coordinates) }
    }
  }

  func fetchNearbySettlement() {
    fetch {
      let settlement = try await apiClient.getNearestSettlement(latitude: 59.945223,
                                                                longitude: 30.365061)
      return [PreviewItem(id: "Settlement",
                          title: settlement.title,
                          description: "\(settlement.latitude), \(settlement.longitude)")]
    }
  }

  func fetchCarrier() {
    fetch {
      let carrier = try await apiClient.getCarrier(code: "680")
      return [PreviewItem(id: carrier.code, title: carrier.title, description: carrier.address)]
    }
  }

  func fetchStations() {
    fetch {
      let stations = try await apiClient.getAllStations()
      return stations.map { PreviewItem(id: $0.code, title: $0.title, description: $0.coordinates) }
    }
  }

  func fetchCopyright() {
    fetch {
      let copy = try await apiClient.getCopyright()
      return [PreviewItem(id: "CP", title: "Copyright", description: copy)]
    }
  }
}

#if DEBUG
  struct PreviewClient: APIServiceProtocol {
    func getNearestStations(latitude _: Float, longitude _: Float) async throws -> [Station] {
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

    func getNearestSettlement(latitude: Float, longitude: Float) async throws -> Settlement {
      Settlement(title: "Minsk", latitude: 53.9045, longitude: 27.5615)
    }

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

    func getCopyright() async throws -> String {
      "© 2024 TravelSchedule"
    }
  }

  #Preview {
    ContentView(apiClient: PreviewClient())
  }

#endif
