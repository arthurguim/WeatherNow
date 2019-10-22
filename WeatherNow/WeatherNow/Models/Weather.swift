//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct Weather {
    let currentTemperature: Double
    let description: String
    let cityName: String
    let maxTemperature: Double
    let minTemperature: Double

    init(data: OWData) {
        self.currentTemperature = data.main.temp
        self.description = data.weather.first!.description
        self.cityName = data.name
        self.maxTemperature = data.main.temp_max
        self.minTemperature = data.main.temp_min
    }
}
