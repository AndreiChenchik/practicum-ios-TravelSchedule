//
//  ScheduleItem.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import Foundation

struct ScheduleItem: Identifiable {
  let id: String
  let carrier: CarrierInfo
  let transferWarning: String?
  let date: String
  let departureTime: String
  let duration: String
  let arrivalTime: String
}
