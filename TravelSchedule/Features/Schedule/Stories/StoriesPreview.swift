//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import SwiftUI

struct StoriesPreview: View {
  @StateObject private var viewModel = StoriesViewModel()
  @State private var storiesToDisplay: [Story]?

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 12) {
        ForEach(viewModel.allStories) { story in
          Button {
            storiesToDisplay = viewModel.unreadStories
          } label: {
            StoryThumbnail(story: story, isRead: viewModel.readStorieIDs.contains(story.id))
          }
          .disabled(viewModel.readStorieIDs.contains(story.id))
        }
      }
      .padding(.vertical, 24)
      .padding(.horizontal, 16)
    }
    .frame(height: 188)
    .task { viewModel.loadStories() }
    .fullScreenCover(item: $storiesToDisplay) { stories in
      UnreadStoriesView(stories: stories, markAsRead: viewModel.markAsRead)
    }
  }
}

extension [Story]: Identifiable {
  public var id: String { "stories" }
}

#Preview {
  VStack {
    StoriesPreview()
    Spacer()
  }
}
