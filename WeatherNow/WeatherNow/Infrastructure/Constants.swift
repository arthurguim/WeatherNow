//
//  Constants.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation
import UIKit

// MARK: - API constants
struct APIConstants {
    static let openWeatherUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    static let openWeatherImageUrl: String = "https://openweathermap.org/img/wn/%@@2x.png"
    static let latitudeKey: String = "lat"
    static let longitudeKey: String = "lon"
    static let apiKey = "appid"
    static let apiKeyValue = "4aca70dd37ed61107867e40e6b2f8a64"
    static let unitKey = "units"
    static let unitValue: String = "metric"
    static let languageKey: String = "lang"
    static let usEnglishLanguage: String = "en-US"
}

// MARK: - App constants
struct AppContants {
    static let temperatureNoValue: String = "--°"
    static let humidityNoValue: String = "--"
    static let descriptionNoValue: String = "---------"
    static let cityNameWithCountryTemplate: String = "%@, %@"
}

// MARK: - CacheService constants
struct CacheConstants {
    static let appleCacheName: String = "apple"
    static let imageNameFlag: String = "_Image"
    static let imageCacheName: String = "%@\(imageNameFlag)"
}

// MARK: - MainViewController constants
struct MainViewConstants {
    static let citysCollectionViewCellCornerRadius: CGFloat = 10
    static let cityCollectionViewHeight: CGFloat = 120
}

// MARK: - InfoViewController constants
struct InfoConstants {
    static let freepikUrl = "https://www.flaticon.com/authors/freepik"
    static let flatIconUrl = "https://www.flaticon.com/"
    static let openWeatherMapUrl = "https://openweathermap.org/"
}
