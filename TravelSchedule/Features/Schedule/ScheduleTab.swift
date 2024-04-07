//
//  ScheduleTab.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import SwiftUI

struct ScheduleTab: View {
@State private var isNavigating = false
  var body: some View {
    NavigationView {
      VStack {
        StoriesPreview()
        
        ScheduleSelector()
          .padding(.horizontal, 16)
          .padding(.top, 20)
        
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
