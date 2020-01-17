//
//  UILabel+Extension.swift
//  WeatherNow
//
//  Created by Arthur Silva on 17/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

extension UILabel {
    func localizedValue(identifier: String, value: String? = nil, defaultValue: String) {
        self.text = String.init(format: NSLocalizedString(identifier, comment: ""), value ?? defaultValue)
    }
}
