//
//  CustomBackButton.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
  @Environment(\.dismiss) var dismiss

  func body(content: Content) -> some View {
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
  }
}

extension View {
  func withCustomBackButton() -> some View {
    modifier(CustomBackButton())
  }
}

#if DEBUG
  #Preview {
    NavigationView {
      Text("Hello World")
        .withCustomBackButton()
    }
  }
#endif
