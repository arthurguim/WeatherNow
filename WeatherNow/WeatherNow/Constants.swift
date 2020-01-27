//
//  Constants.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

// MARK: - API constants
struct APIConstants {
    static let openWeatherUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    static let openWeatherImageUrl: String = "https://openweathermap.org/img/wn/%@@2x.png"
    static let latitudeKey: String = "lat"
    static let longitudeKey: String = "lon"
    static let apiKey = "appid"
    static let apiKeyValue = ""
    static let unitKey = "units"
    static let unitValue: String = "metric"
    static let languageKey: String = "lang"
    static let usEnglishLanguage: String = "en-US"
}

// MARK: - App constants
struct AppContants {
    static let temperatureNoValue: String = "--°"
    static let humidityNoValue: String = "--"
}

// MARK: - InfoViewController constants
struct InfoConstants {
    static let freepikUrl = "https://www.flaticon.com/authors/freepik"
    static let flatIconUrl = "https://www.flaticon.com/"
    static let openWeatherMapUrl = "https://openweathermap.org/"
}
