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

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 8) {
        Text(direction)
          .font(.system(size: 24, weight: .bold))
          .padding(.bottom, 8)

        ForEach(items) { item in
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
    .safeAreaInset(edge: .bottom) {
      CustomButton(title: "Уточнить время") {
        print("Уточнить")
      }
      .padding(16)
    }
    .withCustomBackButton(isEnabled: true)
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      TrainSelector(direction: "Moscow → Moon")
    }
  }
#endif
