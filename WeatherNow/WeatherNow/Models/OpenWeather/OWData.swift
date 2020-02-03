//
//  Weather.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation

struct OWData: Decodable {
    let id: Int
    let weather: [OWWeather]
    let main: OWMain
    let sys: OWSys
    let name: String
}
