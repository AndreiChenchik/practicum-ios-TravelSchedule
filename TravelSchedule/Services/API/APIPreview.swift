//
//  APIPreview.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

#if DEBUG
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

  struct APIPreview: View {
    let apiClient: APIServiceProtocol

    @State private var items: [PreviewItem] = []
    @State private var isInFlightRequest = false
    @State private var searchText = ""

    var filteredItems: [PreviewItem] {
      if searchText.isEmpty {
        return items
      }

      return items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
      NavigationView {
        Form {
          Section("Status") {
            Text(isInFlightRequest ? "Fetching data..." : "Idle")
          }

          Section("Fetch") {
            VStack(alignment: .leading) {
              Button("Search /search/") { fetchSchedule() }
              Text("Загрузить нити от s9600766 к s2000009")
                .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading) {
              Button("Schedule /schedule/") { fetchSchedule() }
              Text("Загрузить расписание s9600766")
                .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading) {
              Button("Thread /thread/") { fetchThread() }
              Text("Загрузить первую нить s9600766")
                .foregroundStyle(.secondary)
            }

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

          if !filteredItems.isEmpty {
            Section("Fetched (first 10 max)") {
              ForEach(filteredItems.prefix(10), content: PreviewItemView.init)
            }
          }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("API Яндекс Расписаний")
        .searchable(text: $searchText)
      }
    }
  }

  private extension APIPreview {
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

    func fetchThreads() {
      fetch {
        let threads = try await apiClient.getThreads(from: "s9600766", to: "s2000009")
        return threads.map { PreviewItem(id: $0.uid, title: $0.title, description: $0.days) }
      }
    }

    func fetchSchedule() {
      fetch {
        let threads = try await apiClient.getSchedule(station: "s9600766")
        return threads.map { PreviewItem(id: $0.uid, title: $0.title, description: $0.days) }
      }
    }

    func fetchThread() {
      fetch {
        let threads = try await apiClient.getSchedule(station: "s9600766")
        let thread = try await apiClient.getThread(uid: threads.first?.uid ?? "thread")
        return thread.map { PreviewItem(id: $0.code, title: $0.title, description: $0.coordinates) }
      }
    }

    func fetchNearesStations() {
      fetch {
        let stations = try await apiClient.getNearestStations(latitude: 59.945223,
                                                              longitude: 30.365061)
        return stations
          .map { PreviewItem(id: $0.code, title: $0.title, description: $0.coordinates) }
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
        return stations
          .map { PreviewItem(id: $0.code, title: $0.title, description: $0.coordinates) }
      }
    }

    func fetchCopyright() {
      fetch {
        let copy = try await apiClient.getCopyright()
        return [PreviewItem(id: "CP", title: "Copyright", description: copy)]
      }
    }
  }

  struct PreviewClient: APIServiceProtocol {
    func getThreads(from _: String, to _: String) async throws -> [Thread] {
      [
        Thread(uid: "6307_0_9601681_g24_4",
               title: "Thread 6307_0_9601681_g24_4",
               days: "All"),
      ]
    }

    func getSchedule(station _: String) async throws -> [Thread] {
      [
        Thread(uid: "6307_0_9601681_g24_4",
               title: "Thread 6307_0_9601681_g24_4",
               days: "All"),
      ]
    }

    func getThread(uid _: String) async throws -> [Station] {
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

    func getNearestStations(latitude _: Float, longitude _: Float) async throws -> [Station] {
      [
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
      [
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
    APIPreview(apiClient: PreviewClient())
  }

#endif
