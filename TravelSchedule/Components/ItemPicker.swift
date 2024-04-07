//
//  ItemPicker.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct ItemPicker<Content: View>: View {
  let items: [PickerItem]
  let noResultsText: String
  var onSelection: ((PickerItem) -> Void)?
  var content: ((PickerItem) -> Content)?

  @State private var searchText = ""
  @State private var isPresenting = false
  @State private var selectedItem: PickerItem?

  private var filteredItems: [PickerItem] {
    searchText.isEmpty ? items : items.filter { $0.label.contains(searchText) }
  }

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(filteredItems, content: cell)
      }
      .padding(.horizontal, 16)
    }
    .frame(maxWidth: .infinity)
    .background { navigation }
    .overlay {
      if filteredItems.isEmpty {
        Text(noResultsText)
          .font(.system(size: 24, weight: .bold))
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .withCustomBackButton()
    .searchable(text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Введите запрос")
  }

  private func cell(for item: PickerItem) -> some View {
    Button {
      onItemTap(item)
    } label: {
      Text(item.label)
        .font(.system(size: 17))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .overlay(alignment: .trailing) {
          Image("chevron")
            .resizable()
            .frame(width: 24, height: 24)
        }
    }
    .foregroundStyle(.black)
  }

  private func onItemTap(_ item: PickerItem) {
    if content != nil {
      selectedItem = item
      isPresenting = true
    }

    onSelection?(item)
  }

  private var navigation: some View {
    NavigationLink(isActive: $isPresenting) {
      if let selectedItem {
        content?(selectedItem)
      }
    } label: {
      EmptyView()
    }
  }
}

extension ItemPicker where Content == EmptyView {
  init(items: [PickerItem], noResultsText: String, onSelection: ((PickerItem) -> Void)? = nil) {
    self.items = items
    self.noResultsText = noResultsText
    self.onSelection = onSelection
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      ItemPicker(
        items: .citiesMock,
        noResultsText: "Город не найден",
        content: { Text("Selected item: \($0.label)") }
      )
      .navigationTitle("Выбор города")
    }
  }
#endif
