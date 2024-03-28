//
//  ContentView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 28.03.24.
//

import OpenAPIURLSession
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
    .task {
      do {
        try stations()
      } catch {
        print(error)
      }
    }
  }

  func stations() throws {
    let client = try Client(
      serverURL: Servers.server1(),
      transport: URLSessionTransport()
    )

    let service = NearestStationsService(
      client: client,
      apikey: "KEY"
    )

    Task {
      do {
        let stations = try await service.getNearestStations(
          lat: 59.864177,
          lng: 30.319163,
          distance: 50
        )
        print(stations)
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  ContentView()
}
