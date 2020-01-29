//
//  CityCollectionViewCell.swift
//  WeatherNow
//
//  Created by Arthur Silva on 29/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!

    static let viewIdentifier: String = "CityCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setWeather(_ weather: Weather) {

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter

        self.cityNameLabel.text = weather.cityName
        self.currentTempLabel.text = measurementFormatter.string(from: weather.currentTemperature)
        self.weatherImageView.image = weather.image

        let maxTemperature = measurementFormatter.string(from: weather.maxTemperature)
        self.maxTempLabel.localizedValue(identifier: "Max_Temp_Label", value: maxTemperature, defaultValue: AppContants.temperatureNoValue)

        let minTemperature = measurementFormatter.string(from: weather.minTemperature)
        self.minTempLabel.localizedValue(identifier: "Min_Temp_Label", value: minTemperature, defaultValue: AppContants.temperatureNoValue)
    }
}
