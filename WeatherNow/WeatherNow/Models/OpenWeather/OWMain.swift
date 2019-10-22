//
//  OWMain.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWMain: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}
