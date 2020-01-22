//
//  MainViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    // MARK: - Local parameters
    var weatherService: OpenWeatherService?
    var locationManager: CLLocationManager?
    var cacheService: CacheService?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.weatherService = OpenWeatherService()

        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self

        self.cacheService = CacheService()
        self.displayCachedData()
    }

    // MARK: - Local functions
    func localizeLabels() {
        self.mainNavigationItem.title = Bundle.main.localizedInfoDictionary!["CFBundleDisplayName"] as? String
        self.maxTemperatureLabel.localizedValue(identifier: "Max_Temp_Label", defaultValue: AppContants.temperatureNoValue)
        self.minTemperatureLabel.localizedValue(identifier: "Min_Temp_Label", defaultValue: AppContants.temperatureNoValue)
        self.humidityLabel.localizedValue(identifier: "Humidity_Label", defaultValue: AppContants.humidityNoValue)
        self.feelsLikeLabel.localizedValue(identifier: "Feels_Like_Label", defaultValue: AppContants.temperatureNoValue)
    }

    func updateView(weather: Weather) {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter

        self.currentTemperatureLabel.text = measurementFormatter.string(for: weather.currentTemperature)
        self.cityNameLabel.text = weather.cityName
        self.weatherDescriptionLabel.text = weather.description.firstLetterCapitalized

        let maxTemperature = measurementFormatter.string(from: weather.maxTemperature)
        self.maxTemperatureLabel.localizedValue(identifier: "Max_Temp_Label", value: maxTemperature, defaultValue: AppContants.temperatureNoValue)
        let minTemperature = measurementFormatter.string(from: weather.minTemperature)
        self.minTemperatureLabel.localizedValue(identifier: "Min_Temp_Label", value: minTemperature, defaultValue: AppContants.temperatureNoValue)
        let feelsLike = measurementFormatter.string(from: weather.feelsLike)
        self.feelsLikeLabel.localizedValue(identifier: "Feels_Like_Label", value: feelsLike, defaultValue: AppContants.temperatureNoValue)
        let humidity = numberFormatter.string(for: weather.humidity)
        self.humidityLabel.localizedValue(identifier: "Humidity_Label", value: humidity, defaultValue: AppContants.humidityNoValue)

        self.messageTitleLabel.isHidden = true
        self.messageLabel.isHidden = true
    }

    func setMessage(titleKey: String, messageKey: String) {
        self.messageTitleLabel.text = NSLocalizedString(titleKey, comment: "")
        self.messageLabel.text = NSLocalizedString(messageKey, comment: "")
        self.messageTitleLabel.isHidden = false
        self.messageLabel.isHidden = false
    }

    func displayCachedData() {
        guard let data = self.cacheService?.loadData() else {
            self.localizeLabels()
            return
        }

        do {
            let owData = try JSONDecoder().decode(OWData.self, from: data)
            updateView(weather: Weather(data: owData))
        } catch {
            print("Error decoding cached data: \(error.localizedDescription)")
            self.localizeLabels()
        }
    }

    // MARK: - Actions
    @IBAction func didTapAddCityButton(_ sender: UIButton) {
        let citySelectionViewController = CitySelectionTableViewController(style: .grouped)
        self.navigationController?.pushViewController(citySelectionViewController, animated: true)
    }

    @IBAction func didTapRefreshButton(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .denied {
            return
        }

        self.activityIndicator.startAnimating()
        self.refreshButton.isEnabled = false
        self.locationManager?.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedWhenInUse:
            self.refreshButton.isEnabled = true
            self.messageTitleLabel.isHidden = true
            self.messageLabel.isHidden = true
            self.activityIndicator.startAnimating()
            self.refreshButton.isEnabled = false
            self.locationManager?.requestLocation()
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            self.refreshButton.isEnabled = false
        case .denied:
            self.setMessage(titleKey: "Permition_Not_Granted_Title", messageKey: "Permition_Not_Granted_Message")
            self.refreshButton.isEnabled = false
        default:
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        self.weatherService?.getData(lat: latitude, lon: longitude, completion: { weather in
            self.activityIndicator.stopAnimating()
            self.refreshButton.isEnabled = true

            guard let weather = weather else {
                self.setMessage(titleKey: "Fetch_Weather_Title", messageKey: "Fetch_Weather_Message")
                return
            }
            self.updateView(weather: weather)
        })
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.setMessage(titleKey: "Fetch_Location_Title", messageKey: "Fetch_Location_Message")
        self.activityIndicator.stopAnimating()
        self.refreshButton.isEnabled = true
        return
    }
}
