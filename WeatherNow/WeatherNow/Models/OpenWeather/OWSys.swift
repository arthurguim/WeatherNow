//
//  OWSys.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWSys: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let coutry: String?
    let sunrise: TimeInterval
    let sunset: TimeInterval
}
