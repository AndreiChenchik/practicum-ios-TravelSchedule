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

  extension ScheduleItem {
    static var mock: Self {
      ScheduleItem(id: "1",
                   carrier: CarrierInfo(
                     name: "Аэрофлот",
                     logoUrl: URL(string: "https://picsum.photos/id/23/200/200")!
                   ),
                   transferWarning: "С пересадкой в Стамбуле",
                   date: "21 июля",
                   departureTime: "12:00",
                   duration: "3 ч 30 мин",
                   arrivalTime: "15:30")
    }
  }

  extension Array where Element == ScheduleItem {
    static var mock: Self {
      [
        ScheduleItem(id: "1",
                     carrier: CarrierInfo(
                       name: "Аэрофлот",
                       logoUrl: URL(string: "https://picsum.photos/id/23/200/200")!
                     ),
                     transferWarning: "С пересадкой в Стамбуле",
                     date: "21 июля",
                     departureTime: "12:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "15:30"),
        ScheduleItem(id: "2",
                     carrier: CarrierInfo(
                       name: "S7",
                       logoUrl: URL(string: "https://picsum.photos/id/122/200/200")!
                     ),
                     transferWarning: nil,
                     date: "21 июля",
                     departureTime: "14:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "17:30"),
        ScheduleItem(id: "3",
                     carrier: CarrierInfo(
                       name: "Pobeda",
                       logoUrl: URL(string: "https://picsum.photos/id/84/200/200")!
                     ),
                     transferWarning: nil,
                     date: "21 июля",
                     departureTime: "16:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "19:30"),
        ScheduleItem(id: "4",
                     carrier: CarrierInfo(
                       name: "Red Wings",
                       logoUrl: URL(string: "https://picsum.photos/id/171/200/200")!
                     ),
                     transferWarning: nil,
                     date: "21 июля",
                     departureTime: "18:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "21:30"),
        ScheduleItem(id: "5",
                     carrier: CarrierInfo(
                       name: "Utair",
                       logoUrl: URL(string: "https://picsum.photos/id/120/200/200")!
                     ),
                     transferWarning: nil,
                     date: "21 июля",
                     departureTime: "20:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "23:30"),
        ScheduleItem(id: "6",
                     carrier: CarrierInfo(
                       name: "S7",
                       logoUrl: URL(string: "https://picsum.photos/id/135/200/200")!
                     ),
                     transferWarning: nil,
                     date: "21 июля",
                     departureTime: "22:00",
                     duration: "3 ч 30 мин",
                     arrivalTime: "23:30")
      ]
    }
  }

  extension CarrierInfo {
    static var mock: Self {
      CarrierInfo(name: "Аэрофлот",
                  logoUrl: URL(string: "https://picsum.photos/id/23/200/200")!)
    }
  }
#endif
