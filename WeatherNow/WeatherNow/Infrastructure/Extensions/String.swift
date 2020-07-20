//
//  String+Extension.swift
//  WeatherNow
//
//  Created by Arthur Silva on 17/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import Foundation

extension String {
    var firstLetterCapitalized: String {
        get {
            return prefix(1).capitalized + dropFirst()
        }
    }
}
