//
//  Story.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 05.04.24.
//

import Foundation

struct Story: Identifiable {
  let id: UUID
  let title: String
  let description: String
  let imageURL: URL
}
