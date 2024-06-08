//
//  StoryView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import SwiftUI

struct StoryView: View {
  let story: Story

  private var labelView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(story.title)
        .lineLimit(2)
        .font(.system(size: 34, weight: .bold))

      Text(story.description)
        .lineLimit(3)
        .font(.system(size: 20))
    }
    .multilineTextAlignment(.leading)
    .foregroundStyle(Color.ypWhite)
  }

  private let shape = RoundedRectangle(cornerRadius: 40)

  var body: some View {
    labelView
      .padding(.horizontal, 16)
      .padding(.bottom, 40)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .background { StoryImage(story: story) }
      .clipShape(shape)
  }
}

#Preview {
  StoryView(story: .mock)
}
