//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation
import UIKit

struct Weather: Identifiable {
    let id = UUID()

    let currentTemperature: Measurement<UnitTemperature>
    let iconName: String
    let description: String
    let cityName: String
    let cityCountry: String
    let cityId: String
    let maxTemperature: Measurement<UnitTemperature>
    let minTemperature: Measurement<UnitTemperature>
    let feelsLike: Measurement<UnitTemperature>
    let humidity: Double
    var image: UIImage? = nil

    init(data: OWData) {
        self.currentTemperature = data.main.currentTemperature
        self.cityName = data.name
        self.cityCountry = data.sys.country
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

    init(currentTemperature: Measurement<UnitTemperature>,
         iconName: String,
         description: String,
         cityName: String,
         cityCountry: String,
         cityId: String,
         maxTemperature: Measurement<UnitTemperature>,
         minTemperature: Measurement<UnitTemperature>,
         feelsLike: Measurement<UnitTemperature>,
         humidity: Double,
         image: UIImage? = nil) {

        self.currentTemperature = currentTemperature
        self.iconName = iconName
        self.description = description
        self.cityName = cityName
        self.cityCountry = cityCountry
        self.cityId = cityId
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.image = image
    }
}

#if DEBUG
let testTemp: Measurement<UnitTemperature> = Measurement.init(value: 30, unit: UnitTemperature.celsius)
let testData = [
    Weather(currentTemperature: testTemp,
            iconName: "Sun_icon",
            description: "Sun",
            cityName: "Rio de Janeiro",
            cityCountry: "BR",
            cityId: "12345",
            maxTemperature: testTemp,
            minTemperature: testTemp,
            feelsLike: testTemp,
            humidity: 50.0)
]
#endif
