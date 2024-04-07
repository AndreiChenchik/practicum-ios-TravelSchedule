//
//  ScheduleSelector.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct ScheduleSelector: View {
  @State private var isSelectingStation = false
  @State private var from: String?
  @State private var to: String?
  @State private var isSelectingTo = false

  var body: some View {
    VStack(spacing: 16) {
      sheduleSeletionBlock

      if from != nil, to != nil {
        searchButton
      }
    }
    .background { navigation }
  }

  private var searchButton: some View {
    Button {
      print("lets start")
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
        button(label: from, prompt: "Откуда") {
          isSelectingTo = false
          isSelectingStation = true
        }

        button(label: to, prompt: "Куда") {
          isSelectingTo = true
          isSelectingStation = true
        }
      }
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))

      Button(action: swapSelection) {
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

  private func swapSelection() {
    let temp = from
    from = to
    to = temp
  }

  private func selected(_ selection: String) {
    if isSelectingTo {
      to = selection
    } else {
      from = selection
    }

    isSelectingStation = false
  }

  private var navigation: some View {
    NavigationLink(isActive: $isSelectingStation) {
      ItemPicker(
        items: .citiesMock,
        noResultsText: "Город не найден",
        content: { city in
          ItemPicker(
            items: .stationsMock,
            noResultsText: "Станция не найдена",
            onSelection: { station in
              selected("\(city.label) (\(station.label))")
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
}

#if DEBUG
  #Preview {
    ScheduleSelector()
  }
#endif
