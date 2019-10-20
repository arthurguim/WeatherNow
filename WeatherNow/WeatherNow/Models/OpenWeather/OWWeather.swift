//
//  OWWeather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWWeather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
