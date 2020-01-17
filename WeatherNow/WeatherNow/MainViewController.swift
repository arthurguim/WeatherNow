//
//  MainViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizeView()

        let service = OpenWeatherService()
        service.getData { weather in

            guard let weather = weather else { return }

            self.updateView(weather: weather)
        }
    }

    func localizeView() {
        self.maxTemperatureLabel.localizedValue(identifier: "Max_Temp_Label", defaultValue: AppContants.temperatureNoValue)
        self.minTemperatureLabel.localizedValue(identifier: "Min_Temp_Label", defaultValue: AppContants.temperatureNoValue)
        self.pressureLabel.localizedValue(identifier: "Pressure_Label", defaultValue: AppContants.pressureNoValue)
    }

    func updateView(weather: Weather) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter

        self.currentTemperatureLabel.text = measurementFormatter.string(for: weather.currentTemperature)
        self.cityNameLabel.text = weather.cityName
        self.weatherDescriptionLabel.text = weather.description

        let maxTemperature = measurementFormatter.string(from: weather.maxTemperature)
        self.maxTemperatureLabel.localizedValue(identifier: "Max_Temp_Label", value: maxTemperature, defaultValue: AppContants.temperatureNoValue)
        let minTemperature = measurementFormatter.string(from: weather.minTemperature)
        self.minTemperatureLabel.localizedValue(identifier: "Min_Temp_Label", value: minTemperature, defaultValue: AppContants.temperatureNoValue)
        let pressure = measurementFormatter.string(from: weather.pressure)
        self.pressureLabel.localizedValue(identifier: "Pressure_Label", value: pressure, defaultValue: AppContants.pressureNoValue)
    }

    @IBAction func didTapAddCity(_ sender: UIBarButtonItem) {
        let citySelectionViewController = CitySelectionTableViewController(style: .grouped)
        self.navigationController?.pushViewController(citySelectionViewController, animated: true)
    }
}
