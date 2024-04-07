//
//  TrainFilterSettings.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import Foundation

struct TrainFilterSettings {
  var partsOfDay: Set<PartOfDay> = []
  var showOnlyDirect = false

  enum PartOfDay: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
  }
}
