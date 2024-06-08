//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct CarrierInfoView: View {
  let carrier: CarrierInfo

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        carrierLogo
        carrierName
          .padding(.vertical, 16)

        infoCell(title: "E-mail", value: carrier.email)
        infoCell(title: "Телефон", value: carrier.phone)
      }
      .padding(16)
    }
    .navigationTitle("Информация о перевозчике")
    .withCustomBackButton(isEnabled: true)
  }

  var carrierLogo: some View {
    Color.clear
      .frame(maxWidth: .infinity)
      .frame(height: 104)
      .background {
        AsyncImage(url: carrier.logoUrl) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          Color.lightGrayUniversal
        }
      }
      .clipped()
  }

  private var carrierName: some View {
    Text(carrier.fullName)
      .font(.system(size: 24, weight: .bold))
  }

  private func infoCell(title: String, value: String) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(title)
        .font(.system(size: 17))

      Text(value)
        .font(.system(size: 12))
        .foregroundStyle(.blueUniversal)
    }
    .padding(.vertical, 12)
  }
}

#Preview {
  NavigationView {
    CarrierInfoView(carrier: .mock)
      .navigationBarTitleDisplayMode(.inline)
  }
}
