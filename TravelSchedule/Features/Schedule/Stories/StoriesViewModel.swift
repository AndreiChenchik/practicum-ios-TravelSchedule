//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import Foundation

final class StoriesViewModel: ObservableObject {
  @Published var stories: [Story] = []
  @Published var readStorieIDs: Set<Story.ID> = []

  var unreadStories: [Story] {
    stories.filter { !readStorieIDs.contains($0.id) }
  }

  var readStories: [Story] {
    stories.filter { readStorieIDs.contains($0.id) }
  }

  var allStories: [Story] {
    unreadStories + readStories
  }

  let getStories: () -> [Story] = { .mock }

  func loadStories() {
    guard stories.isEmpty else { return }
    stories = getStories()
  }

  func markAsRead(id: Story.ID) {
    readStorieIDs.insert(id)
  }
}
