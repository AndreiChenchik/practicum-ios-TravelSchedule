//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import SwiftUI

struct ScheduleView: View {
  var body: some View {
    VStack {
      StoriesPreview()

      Spacer()
    }
  }
}

#if DEBUG
  #Preview {
    ScheduleView()
  }
#endif
