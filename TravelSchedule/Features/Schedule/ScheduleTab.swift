//
//  ScheduleTab.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import SwiftUI

struct ScheduleTab: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        StoriesPreview()

        ScheduleSelector()
          .padding(.horizontal, 16)

        Spacer()
      }
    }
  }
}

#if DEBUG
  #Preview {
    ScheduleTab()
  }
#endif
