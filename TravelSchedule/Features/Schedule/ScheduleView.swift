//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import SwiftUI

struct ScheduleView: View {
  @StateObject private var viewModel: ViewModel

  init(storiesProvider: @escaping StoriesProvider) {
    _viewModel = StateObject(wrappedValue: ViewModel(storiesProvider: storiesProvider))
  }

  var body: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 12) {
          ForEach(viewModel.stories) { story in
            StoryView(story: story, isRead: viewModel.readStories.contains(story.id))
          }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
      }
      .frame(height: 188)

      Spacer()
    }
    .task { viewModel.loadStories() }
  }
}

struct StoryView: View {
  let story: Story
  let isRead: Bool

  private var imageView: some View {
    AsyncImage(url: story.imageURL) { image in
      image
        .resizable()
        .scaledToFill()
    } placeholder: {
      Color.gray.opacity(0.5)
    }
  }

  private var labelView: some View {
    Text(story.title)
      .lineLimit(3)
      .font(.system(size: 12))
      .foregroundStyle(Color.white)
  }

  private let shape = RoundedRectangle(cornerRadius: 16)

  var body: some View {
    labelView
      .padding(.horizontal, 8)
      .padding(.bottom, 12)
      .frame(width: 92, height: 140, alignment: .bottom)
      .background { imageView }
      .clipped()
      .overlay {
        if isRead {
          shape.strokeBorder(Color.blue, lineWidth: 4)
        }
      }
      .clipShape(shape)
  }
}

private extension ScheduleView {
  final class ViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var readStories: Set<Story.ID> = []

    let storiesProvider: StoriesProvider

    func loadStories() {
      stories = storiesProvider()
      readStories = .init(stories.prefix(3).map(\.id))
    }

    init(storiesProvider: @escaping StoriesProvider) {
      self.storiesProvider = storiesProvider
    }
  }
}

typealias StoriesProvider = () -> [Story]

#if DEBUG

  #Preview {
    ScheduleView {
      (100 ... 200).map {
        Story(id: UUID(),
              title: "Number:\($0) What is Lorem Ipsum exactly?",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
              imageURL: URL(string: "https://picsum.photos/id/\($0)/300/300")!)
      }
    }
  }
#endif
