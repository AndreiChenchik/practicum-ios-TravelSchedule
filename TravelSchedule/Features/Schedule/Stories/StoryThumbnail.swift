//
//  StoryThumbnail.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import SwiftUI

struct StoryThumbnail: View {
  let story: Story
  let isRead: Bool

  private var labelView: some View {
    Text(story.title)
      .lineLimit(3)
      .multilineTextAlignment(.leading)
      .font(.system(size: 12))
      .foregroundStyle(Color.white)
  }

  private let shape = RoundedRectangle(cornerRadius: 16)

  var body: some View {
    labelView
      .padding(.horizontal, 8)
      .padding(.bottom, 12)
      .frame(width: 92, height: 140, alignment: .bottom)
      .background { StoryImage(story: story) }
      .overlay {
        if !isRead {
          shape.strokeBorder(Color.blue, lineWidth: 4)
        }
      }
      .clipShape(shape)
      .opacity(isRead ? 0.5 : 1)
  }
}

#Preview {
  HStack {
    StoryThumbnail(story: .mock, isRead: true)
    StoryThumbnail(story: .mock, isRead: false)
  }
}
