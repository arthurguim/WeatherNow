//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct Weather {
    let currentTemperature: Measurement<UnitTemperature>
    let description: String
    let cityName: String
    let maxTemperature: Measurement<UnitTemperature>
    let minTemperature: Measurement<UnitTemperature>
    let pressure: Measurement<UnitPressure>

    init(data: OWData) {
        self.currentTemperature = data.main.currentTemperature
        self.description = data.weather.first!.description
        self.cityName = data.name
        self.maxTemperature = data.main.maxTemperature
        self.minTemperature = data.main.minTemperature
        self.pressure = data.main.currentPressure
    }
}
