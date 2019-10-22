//
//  OWRain.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/22/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWRain: Decodable {
    let threeHours: Double

    enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
    }
}
