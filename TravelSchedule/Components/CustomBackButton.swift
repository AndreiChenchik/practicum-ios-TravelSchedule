//
//  CustomBackButton.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
  @Environment(\.dismiss) var dismiss

  let isEnabled: Bool

  func body(content: Content) -> some View {
    if isEnabled {
      content
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              dismiss()
            } label: {
              Image(systemName: "chevron.backward")
                .font(.system(size: 17, weight: .semibold))
            }
          }
        }
    } else {
      content
    }
  }
}

extension View {
  func withCustomBackButton(isEnabled: Bool) -> some View {
    modifier(CustomBackButton(isEnabled: isEnabled))
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      Text("Hello World")
        .withCustomBackButton(isEnabled: true)
    }
  }
#endif
