//
//  StoryImage.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import SwiftUI

struct StoryImage: View {
  let story: Story

  var body: some View {
    AsyncImage(url: story.imageURL) { image in
      image
        .resizable()
        .scaledToFill()
    } placeholder: {
      Color.lightGrayUniversal
    }
  }
}

#if DEBUG
  #Preview {
    StoryImage(story: .mock)
      .padding()
  }
#endif
