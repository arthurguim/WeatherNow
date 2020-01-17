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

        localizeView()

        let service = OpenWeatherService()
        service.getData { weather in

            guard let weather = weather else { return }

            self.updateView(weather: weather)
        }
    }

    func localizeView() {
        self.maxTemperatureLabel.text = String.init(format: NSLocalizedString("Max_Temp_Label", comment: ""), "--°")
        self.minTemperatureLabel.text = String.init(format: NSLocalizedString("Min_Temp_Label", comment: ""), "--°")
    }

    func updateView(weather: Weather) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter

        self.currentTemperatureLabel.text = measurementFormatter.string(for: weather.currentTemperature)
        self.maxTemperatureLabel.text = String.init(format: NSLocalizedString("Max_Temp_Label", comment: ""), measurementFormatter.string(for: weather.maxTemperature) ?? "--°")
        self.minTemperatureLabel.text = String.init(format: NSLocalizedString("Min_Temp_Label", comment: ""), measurementFormatter.string(for: weather.minTemperature) ?? "--°")

        self.cityNameLabel.text = weather.cityName
        self.weatherDescriptionLabel.text = weather.description
    }

    @IBAction func didTapAddCity(_ sender: UIBarButtonItem) {
        let citySelectionViewController = CitySelectionTableViewController(style: .grouped)
        self.navigationController?.pushViewController(citySelectionViewController, animated: true)
    }
}
