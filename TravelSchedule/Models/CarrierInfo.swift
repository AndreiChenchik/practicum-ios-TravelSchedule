//
//  CarrierInfo.swift
//  TravelSchedule
//
//  Created by andrei.chenchik on 07.04.24.
//

import Foundation

struct CarrierInfo {
  let name: String
  let logoUrl: URL
  var fullName: String { "ОАО «\(name)»" }
  let email: String = "hello@world.com"
  let phone: String = "+375 29 123 45 67"
}
