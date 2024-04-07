//
//  CustomButton.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct CustomButton: View {
  @Environment(\.isEnabled) var isEnabled

  let title: String
  let onTap: () -> Void

  var body: some View {
    Button {
      onTap()
    } label: {
      Text(title)
        .font(.system(size: 17, weight: .bold))
        .foregroundStyle(.white)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(isEnabled ? .blue : .gray)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    .opacity(isEnabled ? 1 : 0.5)
    .disabled(!isEnabled)
  }
}

#Preview {
  CustomButton(title: "Найти") {
    print("Button tapped")
  }
}
