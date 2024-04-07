//
//  StationSelector.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct StationSelector: View {
  @Environment(\.dismiss) var dismiss

  let onComplete: (String) -> Void

  var body: some View {
    NavigationView {
      ItemPicker(
        items: .citiesMock,
        noResultsText: "Город не найден",
        content: { city in
          ItemPicker(
            items: .stationsMock,
            noResultsText: "Станция не найдена",
            onSelection: { station in
              onComplete("\(city.label) (\(station.label))")
              dismiss()
            },
            withCustomBackButton: true
          )
          .navigationTitle("Выбор станции")
        }
      )
      .navigationTitle("Выбор города")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "xmark")
              .font(.system(size: 17, weight: .semibold))
          }
        }
      }
    }
  }
}

#if DEBUG
  #Preview {
    StationSelector { print($0) }
  }
#endif
