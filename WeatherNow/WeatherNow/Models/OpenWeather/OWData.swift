//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWData: Decodable {
    let coord: OWCoord?
    let weather: [OWWeather]?
    let base: String?
    let main: OWMain?
    let visibility: Int?
    let wind: OWWind?
    let clouds: OWClouds?
    let dt: Int?
    let sys: OWSys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}
