//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation
import UIKit

struct Weather {
    let currentTemperature: Measurement<UnitTemperature>
    let iconName: String
    let description: String
    let cityName: String
    let cityId: String
    let maxTemperature: Measurement<UnitTemperature>
    let minTemperature: Measurement<UnitTemperature>
    let feelsLike: Measurement<UnitTemperature>
    let humidity: Double
    var image: UIImage? = nil

    init(data: OWData) {
        self.currentTemperature = data.main.currentTemperature
        self.cityName = data.name
        self.cityId = String(data.id)
        self.maxTemperature = data.main.maxTemperature
        self.minTemperature = data.main.minTemperature
        self.feelsLike = data.main.feelsLike
        self.humidity = data.main.humidity

        guard let weather = data.weather.first else {
            self.description = ""
            self.iconName = ""
            return
        }

        self.description = weather.description
        self.iconName = weather.icon
    }
}
