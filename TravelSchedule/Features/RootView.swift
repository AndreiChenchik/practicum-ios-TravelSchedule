//
//  RootView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import SwiftUI

struct RootView: View {
  var body: some View {
    TabView {
      ScheduleTab()
        .tabItem {
          Image(.schedule)
            .resizable()
        }

      APIPreview()
        .tabItem {
          Image(.settings)
            .resizable()
        }
    }
  }
}

#if DEBUG
  #Preview {
    RootView()
  }
#endif
