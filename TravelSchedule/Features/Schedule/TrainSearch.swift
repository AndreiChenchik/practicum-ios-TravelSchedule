//
//  TrainSearch.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct TrainSearch: View {
  let direction: String

  var body: some View {
    Text(direction)
      .withCustomBackButton()
  }
}

#if DEBUG
  #Preview {
    TrainSearch(direction: "Moscow → Moon")
  }
#endif
