//
//  Constants.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct APIConstants {
    static let openWeatherUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    static let latitudeKey: String = "lat"
    static let longitudeKey: String = "lon"
    static let apiKey = "appid"
    static let unitKey = "units"
    static let unitValue: String = "metric"
    static let languageKey: String = "lang"
    static let usEnglishLanguage: String = "en-US"
}

struct AppContants {
    static let temperatureNoValue: String = "--°"
    static let pressureNoValue: String = "---- mba"
    static let humidityNoValue: String = "--"

    static let cityName: String = "%@, %@"
}
