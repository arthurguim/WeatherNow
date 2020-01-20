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
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
    let humidity: Double

    var currentTemperature: Measurement<UnitTemperature> {
        get {
            let temperature = Measurement.init(value: self.temp, unit: UnitTemperature.celsius)
            return temperature
        }
    }

    var minTemperature: Measurement<UnitTemperature> {
        get {
            let temperature = Measurement.init(value: self.temp_min, unit: UnitTemperature.celsius)
            return temperature
        }
    }

    var maxTemperature: Measurement<UnitTemperature> {
        get {
            let temperature = Measurement.init(value: self.temp_max, unit: UnitTemperature.celsius)
            return temperature
        }
    }

    var feelsLike: Measurement<UnitTemperature> {
        get {
            let temperature = Measurement.init(value: self.feels_like, unit: UnitTemperature.celsius)
            return temperature
        }
    }
}
