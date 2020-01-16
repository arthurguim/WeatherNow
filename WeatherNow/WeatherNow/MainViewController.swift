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
        self.currentTemperatureLabel.text = String(format: "%.0f", weather.currentTemperature)
        self.weatherDescriptionLabel.text = weather.description
        self.maxTemperatureLabel.text = String(format: "%.0f", weather.maxTemperature)
        self.minTemperatureLabel.text = String(format: "%.0f", weather.minTemperature)
        self.cityNameLabel.text = weather.cityName
    }

    @IBAction func didTapSettings(_ sender: UIButton) {
        let settingsView = SettingsTableViewController(style: .grouped)
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
}
