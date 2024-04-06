//
//  UnreadStoriesView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import SwiftUI

struct UnreadStoriesView: View {
  @Environment(\.dismiss) var dismiss

  let stories: [Story]
  let markAsRead: (Story.ID) -> Void

  @State private var currentIndex = 0
  @State private var progress: Double = 0

  private static let timerFiresEvery: TimeInterval = 0.1
  private static let secondsPerStory: TimeInterval = 3
  private let progressAmount = 1 / (secondsPerStory / timerFiresEvery)
  private let timer = Timer.publish(every: timerFiresEvery, on: .main, in: .common).autoconnect()

  private func progressTimer() {
    if progress < 1 {
      withAnimation {
        progress = min(progress + progressAmount, 1)
      }
    } else {
      switchToNextStory()
    }
  }

  private func switchToNextStory() {
    markAsRead(stories[currentIndex].id)

    if currentIndex < (stories.count - 1) {
      withAnimation {
        currentIndex += 1
        progress = progressAmount
      }
    } else {
      timer.upstream.connect().cancel()
    }
  }

  private func progressView(progress: Double) -> some View {
    ProgressView(value: progress)
      .background { Color.white }
      .clipShape(Capsule())
  }

  private func progressValue(for index: Int) -> Double {
    return if index < currentIndex {
      1
    } else if index > currentIndex {
      0
    } else {
      progress
    }
  }

  private var progressView: some View {
    HStack(spacing: 6) {
      ForEach(0 ..< stories.count, id: \.self) { index in
        progressView(progress: progressValue(for: index))
      }
    }
  }

  private var dismissButton: some View {
    Button {
      dismiss()
    } label: {
      Image("close")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundStyle(.white)
        .padding(3)
        .background { Color.black }
        .clipShape(Circle())
    }
  }

  var body: some View {
    StoryView(story: stories[currentIndex])
      .onTapGesture {
        switchToNextStory()
      }
      .background {
        Color.black.ignoresSafeArea()
      }
      .overlay(alignment: .top) {
        VStack(alignment: .trailing, spacing: 16) {
          progressView
          dismissButton
        }
        .padding(.horizontal, 12)
        .padding(.top, 28)
      }
      .onReceive(timer) { _ in progressTimer() }
  }
}

#Preview {
  let viewModel = StoriesViewModel()
  return UnreadStoriesView(stories: .mock) { _ in }
    .onAppear { viewModel.loadStories() }
}
