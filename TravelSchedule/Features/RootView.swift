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
      ScheduleView { [] }
        .tabItem {
          Image("schedule")
            .resizable()
        }

      Text("Settings")
        .tabItem {
          Image("settings")
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
