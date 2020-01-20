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
    let countryName: String
    let maxTemperature: Measurement<UnitTemperature>
    let minTemperature: Measurement<UnitTemperature>
    let feelsLike: Measurement<UnitTemperature>
    let humidity: Double

    init(data: OWData) {
        self.currentTemperature = data.main.currentTemperature
        self.description = data.weather.first!.description
        self.cityName = data.name
        self.countryName = data.sys.country
        self.maxTemperature = data.main.maxTemperature
        self.minTemperature = data.main.minTemperature
        self.feelsLike = data.main.feelsLike
        self.humidity = data.main.humidity
    }
}
