//
//  ScheduleItemView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct ScheduleItemView: View {
  let item: ScheduleItem

  var body: some View {
    VStack(spacing: 18) {
      HStack(spacing: 8) {
        carrierLogo

        HStack(alignment: .top, spacing: 0) {
          VStack(alignment: .leading, spacing: 0) {
            Text(item.carrier.name)

            if let warning = item.transferWarning {
              transferInfo(warning)
            }
          }

          Spacer()

          dateInfo
        }
      }

      scheduleInfo
    }
    .font(.system(size: 17))
    .foregroundStyle(.black)
    .padding(14)
    .background { Color.lightGrayUniveral }
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }

  private var divider: some View {
    Rectangle()
      .frame(height: 1)
      .foregroundStyle(Color.grayUniversal)
  }

  private var scheduleInfo: some View {
    HStack(spacing: 5) {
      Text(item.departureTime)

      divider

      Text(item.duration)
        .font(.system(size: 12))

      divider

      Text(item.arrivalTime)
    }
  }

  private var carrierLogo: some View {
    Color.clear
      .frame(width: 38, height: 38)
      .background {
        AsyncImage(url: item.carrier.logoUrl) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          Color.lightGrayUniveral
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 12))
  }

  private func transferInfo(_ warning: String) -> some View {
    Text(warning)
      .font(.system(size: 12))
      .foregroundStyle(Color.redUniversal)
  }

  private var dateInfo: some View {
    Text(item.date)
      .font(.system(size: 12))
  }
}

#if DEBUG
  #Preview {
    ScheduleItemView(item: .mock)
      .padding()
  }
#endif
