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

    override func viewDidLoad() {
        super.viewDidLoad()

        let service = OpenWeatherService()
        service.getData { weather in

            guard let weather = weather else { return }

            self.setupView(weather: weather)
        }
    }

    func setupView(weather: Weather) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter

        self.currentTemperatureLabel.text = measurementFormatter.string(for: weather.currentTemperature)
        self.maxTemperatureLabel.text = measurementFormatter.string(for: weather.maxTemperature)
        self.minTemperatureLabel.text = measurementFormatter.string(for: weather.minTemperature)

        self.cityNameLabel.text = weather.cityName
        self.weatherDescriptionLabel.text = weather.description
    }

    @IBAction func didTapAddCity(_ sender: UIBarButtonItem) {
        let citySelectionViewController = CitySelectionTableViewController(style: .grouped)
        self.navigationController?.pushViewController(citySelectionViewController, animated: true)
    }
}
