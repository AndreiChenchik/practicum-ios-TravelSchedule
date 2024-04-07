//
//  TrainSelector.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct TrainSelector: View {
  let direction: String
  let items: [ScheduleItem] = .mock

  @State private var filterSettings = TrainFilterSettings()
  @State private var isShowingTrainFilter = false

  var filteredItems: [ScheduleItem] {
    if filterSettings.partsOfDay.isEmpty {
      items
    } else {
      []
    }
  }

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 8) {
        Text(direction)
          .font(.system(size: 24, weight: .bold))
          .padding(.bottom, 8)

        ForEach(filteredItems) { item in
          NavigationLink {
            CarrierInfoView(carrier: item.carrier)
          } label: {
            ScheduleItemView(item: item)
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.top, 16)
    }
    .overlay {
      if filteredItems.isEmpty {
        Text("Вариантов нет")
          .font(.system(size: 24, weight: .bold))
      }
    }
    .safeAreaInset(edge: .bottom) {
      CustomButton(title: "Уточнить время") {
        isShowingTrainFilter = true
      }
      .padding(16)
    }
    .fullScreenCover(isPresented: $isShowingTrainFilter) {
      NavigationView {
        TrainFilter(settings: $filterSettings)
      }
    }
    .withCustomBackButton(isEnabled: true)
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      TrainSelector(direction: "Moscow → Moon")
    }
    .tint(.ypBlack)
  }
#endif
