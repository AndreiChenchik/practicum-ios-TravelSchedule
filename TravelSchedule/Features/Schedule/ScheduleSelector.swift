//
//  ScheduleSelector.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct ScheduleSelector: View {
  @State private var from: String?
  @State private var to: String?
  @State private var destination: Destination?

  private enum Destination {
    case from
    case to
    case search
  }

  var body: some View {
    VStack(spacing: 16) {
      sheduleSeletionBlock

      if from != nil, to != nil {
        searchButton
      }
    }
    .background {
      selectNavigation
      searchNavigation
    }
  }

  private var searchButton: some View {
    Button {
      destination = .search
    } label: {
      Text("Найти")
        .font(.system(size: 17, weight: .bold))
        .foregroundStyle(.white)
        .padding(.vertical, 20)
        .frame(width: 150)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
  }

  private var sheduleSeletionBlock: some View {
    HStack(spacing: 16) {
      VStack(spacing: 0) {
        button(label: from, prompt: "Откуда") { destination = .from }
        button(label: to, prompt: "Куда") { destination = .to }
      }
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))

      Button {
        (from, to) = (to, from)
      } label: {
        Image("swap")
          .resizable()
          .frame(width: 24, height: 24)
          .padding(6)
          .background(.white)
          .clipShape(Circle())
      }
    }
    .padding(16)
    .background(.blue)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }

  private func button(label: String?, prompt: String, onTap: @escaping () -> Void) -> some View {
    Button(action: onTap) {
      Text(label ?? prompt)
        .lineLimit(1)
        .font(.system(size: 17))
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .foregroundStyle(label == nil ? .gray : .black)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private func selectStation(_ selection: String) {
    switch destination {
    case .from: from = selection
    case .to: to = selection
    default: break
    }

    destination = nil
  }

  private var selectNavigation: some View {
    NavigationLink(
      isActive: .init(get: { destination == .from || destination == .to },
                      set: { _ in destination = nil })
    ) {
      ItemPicker(
        items: .citiesMock,
        noResultsText: "Город не найден",
        content: { city in
          ItemPicker(
            items: .stationsMock,
            noResultsText: "Станция не найдена",
            onSelection: { station in
              selectStation("\(city.label) (\(station.label))")
            }
          )
          .navigationTitle("Выбор станции")
        }
      )
      .navigationTitle("Выбор города")
    } label: {
      EmptyView()
    }
  }

  @ViewBuilder
  private var searchNavigation: some View {
    if let from, let to {
      NavigationLink(
        isActive: .init(get: { destination == .search },
                        set: { _ in destination = nil })
      ) {
        TrainSearch(direction: "\(from) → \(to)")
      } label: {
        EmptyView()
      }
    }
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      ScheduleSelector()
        .padding()
    }
  }
#endif
