//
//  _Mocks.swift
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

  extension Array where Element == PickerItem {
    static var citiesMock: Self {
      [
        PickerItem(id: "1", label: "Москва"),
        PickerItem(id: "2", label: "Санкт Петербург"),
        PickerItem(id: "3", label: "Сочи"),
        PickerItem(id: "4", label: "Горный воздух"),
        PickerItem(id: "5", label: "Краснодар"),
        PickerItem(id: "6", label: "Казань"),
        PickerItem(id: "7", label: "Омск")
      ]
    }

    static var stationsMock: Self {
      [
        PickerItem(id: "1", label: "Киевский вокзал"),
        PickerItem(id: "2", label: "Курский вокзал"),
        PickerItem(id: "3", label: "Ярославский вокзал"),
        PickerItem(id: "4", label: "Белорусский вокзал"),
        PickerItem(id: "5", label: "Савеловский вокзал"),
        PickerItem(id: "6", label: "Ленинградский вокзал")
      ]
    }
  }
#endif
