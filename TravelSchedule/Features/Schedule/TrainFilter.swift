//
//  TrainFilter.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct TrainFilter: View {
  @Environment(\.dismiss) var dismiss

  @Binding var settings: TrainFilterSettings

  @State private var rollbackValue: TrainFilterSettings?

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        header("Время отправления")

        ForEach(TrainFilterSettings.PartOfDay.allCases, id: \.rawValue, content: partOfDayCell)

        header("Показывать варианты с пересадками")

        transferCell(for: true)
        transferCell(for: false)
      }
      .padding(.horizontal, 16)
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(.ypBlack)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          if let rollbackValue {
            settings = rollbackValue
          }
          dismiss()
        } label: {
          Image(systemName: "xmark")
            .font(.system(size: 17, weight: .semibold))
        }
      }
    }
    .safeAreaInset(edge: .bottom) {
      CustomButton(title: "Применить") {
        dismiss()
      }
      .padding(16)
    }
    .onAppear {
      rollbackValue = settings
    }
  }

  private func header(_ title: String) -> some View {
    Text(title)
      .font(.system(size: 24, weight: .bold))
      .foregroundStyle(.ypBlack)
      .padding(.vertical, 16)
  }

  private func partOfDayCell(for item: TrainFilterSettings.PartOfDay) -> some View {
    Button {
      if settings.partsOfDay.contains(item) {
        settings.partsOfDay.remove(item)
      } else {
        settings.partsOfDay.insert(item)
      }
    } label: {
      textCell(item.rawValue)
        .overlay(alignment: .trailing) {
          Image(settings.partsOfDay.contains(item) ? .checkBoxOn : .checkBoxOff)
            .resizable()
            .frame(width: 24, height: 24)
        }
    }
  }

  private func transferCell(for enabled: Bool) -> some View {
    Button {
      settings.showOnlyDirect = enabled
    } label: {
      textCell(enabled ? "Да" : "Нет")
        .overlay(alignment: .trailing) {
          Image(settings.showOnlyDirect == enabled ? .radioOn : .radioOff)
            .resizable()
            .frame(width: 24, height: 24)
        }
    }
  }

  private func textCell(_ label: String) -> some View {
    Text(label)
      .font(.system(size: 17))
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 16)
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      TrainFilter(settings: .constant(.init()))
    }
    .tint(.ypBlack)
  }
#endif
