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
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var locationIndicatorImage: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var otherCitysCollectionView: UICollectionView!

    // MARK: - Local parameters
    var weatherService: OpenWeatherService?
    var locationManager: CLLocationManager?
    var cacheService: CacheService?
    var locationImageBlinkerTimer: Timer?
    var isLocationImageFilled: Bool = false

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.otherCitysCollectionView.dataSource = self
        self.otherCitysCollectionView.delegate = self

        let cityNib = UINib(nibName: CityCollectionViewCell.viewIdentifier, bundle: nil)
        self.otherCitysCollectionView.register(cityNib, forCellWithReuseIdentifier: CityCollectionViewCell.viewIdentifier)

        self.weatherService = OpenWeatherService()

        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self

        self.cacheService = CacheService()
        self.displayCachedData()

        self.locationImageBlinkerTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.7),
                                                              target: self,
                                                              selector: #selector(blinkLocationImage),
                                                              userInfo: nil,
                                                              repeats: true)
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

        self.shouldShowInterface(true)

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
        self.weatherImage.image = weather.image
    }

    func showAlert(titleKey: String, messageKey: String) {
        let title = NSLocalizedString(titleKey, comment: "")
        let message = NSLocalizedString(messageKey, comment: "")

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Alert_OK_Button", comment: ""), style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    func shouldShowInterface(_ shouldShow: Bool) {
        self.weatherImage.isHidden = !shouldShow
        self.maxTemperatureLabel.isHidden = !shouldShow
        self.minTemperatureLabel.isHidden = !shouldShow
        self.cityNameLabel.isHidden = !shouldShow
        self.locationIndicatorImage.isHidden = !shouldShow
        self.feelsLikeLabel.isHidden = !shouldShow
        self.humidityLabel.isHidden = !shouldShow

        if !shouldShow {
            self.currentTemperatureLabel.text = AppContants.temperatureNoValue
            self.weatherDescriptionLabel.text = AppContants.descriptionNoValue
        }
    }

    func displayCachedData() {
        guard let weather = self.cacheService!.loadWeatherData() else {
            self.localizeLabels()
            return
        }

        updateView(weather: weather)
    }

    @objc func blinkLocationImage() {
        if self.isLocationImageFilled {
            UIView.animate(withDuration: 0.6) {
                self.locationIndicatorImage.alpha = 0.3
            }
            self.isLocationImageFilled = false
        } else {
            UIView.animate(withDuration: 0.6) {
                self.locationIndicatorImage.alpha = 1.0
            }
            self.isLocationImageFilled = true
        }
    }

    func startLoadingUi() {
        self.activityIndicator.startAnimating()
        self.refreshButton.isEnabled = false
        self.locationIndicatorImage.isHidden = false
        self.locationImageBlinkerTimer?.fire()
    }

    func stopLoadingUi(withError: Bool = false) {
        self.activityIndicator.stopAnimating()
        self.locationImageBlinkerTimer?.invalidate()
        self.refreshButton.isEnabled = true

        if withError {
            self.locationIndicatorImage.isHidden = true
        } else if self.locationIndicatorImage.alpha != 1.0 {
            UIView.animate(withDuration: 0.6) {
                self.locationIndicatorImage.alpha = 1.0
                self.isLocationImageFilled = true
            }
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
            self.startLoadingUi()
            self.locationManager?.requestLocation()
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            self.refreshButton.isEnabled = false
        case .denied:
            self.showAlert(titleKey: "Permition_Not_Granted_Title", messageKey: "Permition_Not_Granted_Message")
            self.shouldShowInterface(false)
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

            guard var weather = weather else {
                self.stopLoadingUi(withError: true)
                self.showAlert(titleKey: "Fetch_Weather_Title", messageKey: "Fetch_Weather_Message")
                self.shouldShowInterface(false)
                return
            }

            self.weatherService?.downloadImage(cityId: weather.cityId, imageName: weather.iconName, onSuccess: { image in
                weather.image = image

                self.stopLoadingUi()
                self.updateView(weather: weather)
            })
        })
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.showAlert(titleKey: "Fetch_Location_Title", messageKey: "Fetch_Location_Message")
        self.shouldShowInterface(false)
        self.locationIndicatorImage.isHidden = true
        self.stopLoadingUi(withError: true)
        return
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.viewIdentifier, for: indexPath) as? CityCollectionViewCell else {
            fatalError()
        }

        cell.layer.cornerRadius = MainViewConstants.citysCollectionViewCellCornerRadius

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = self.view.frame.width - self.view.frame.width * MainViewConstants.cityCollectionViewWidthPercentage
        let height = self.otherCitysCollectionView.frame.height - self.otherCitysCollectionView.frame.height * MainViewConstants.cityCollectionViewHeightPercentage

        return CGSize(width: width, height: height)
    }
}
