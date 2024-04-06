//
//  Mocks.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 06.04.24.
//

import Foundation

#if DEBUG
  // Stories
  extension Story {
    static var mock: Self {
      let id = "122"
      return Story(id: id,
                   title: "What is Lorem Ipsum exactly?",
                   description: """
                     Lorem Ipsum is simply dummy text of the printing and typesetting industry. \
                     Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \
                     when an unknown printer took a galley of type and scrambled it to make a type \
                     specimen book. It has survived not only five centuries
                     """,
                   imageURL: URL(string: "https://picsum.photos/id/\(id)/800/800")!)
    }
  }

  extension Array where Element == Story {
    static var mock: Self {
      [23, 122, 84, 171, 120, 135].map {
        Story(id: "\($0)",
              title: "Number:\($0) What is Lorem Ipsum exactly?",
              description: """
                Lorem Ipsum is simply dummy text of the printing and typesetting industry. \
                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \
                when an unknown printer took a galley of type and scrambled it to make a type \
                specimen book. It has survived not only five centuries
                """,
              imageURL: URL(string: "https://picsum.photos/id/\($0)/800/800")!)
      }
    }
  }
#endif
