//
//  OpenWeatherService.swift
//  WeatherNow
//
//  Created by Arthur Silva on 10/20/19.
//  Copyright © 2019 Arthur Silva. All rights reserved.
//

import Foundation
import Alamofire

class OpenWeatherService {

    let cacheService = CacheService()

    func getData(lat: String, lon: String, completion: @escaping (Weather?) -> Void) {

        guard let url = URL(string: APIConstants.openWeatherUrl) else {
            completion(nil)
            return
        }

        let language = getLanguage()

        let params: [String:String] = [APIConstants.latitudeKey: lat,
                                       APIConstants.longitudeKey: lon,
                                       APIConstants.apiKey: APIConstants.apiKeyValue,
                                       APIConstants.unitKey: APIConstants.unitValue,
                                       APIConstants.languageKey: language]

        Alamofire.request(url, method: .get, parameters: params).validate().responseData { response in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    completion(nil)
                    return
                }

                do {
                    let owData = try JSONDecoder().decode(OWData.self, from: data)
                    let weather = Weather(data: owData)
                    self.cacheService.deleteAllFiles()
                    self.cacheService.saveData(fileName: weather.cityId, data: data)
                    completion(weather)
                } catch {
                    print("Error decoding weather data: \(error.localizedDescription)")
                    completion(nil)
                }
            case .failure:
                print("Error fetching data from API: \(String(describing: response.error?.localizedDescription))")
                completion(nil)
            }
        }
    }

    func getLanguage() -> String {
        guard let collatorId = NSLocale.current.collatorIdentifier else {
            return APIConstants.usEnglishLanguage
        }

        return NSLocale.preferredLanguages.contains(collatorId) ? NSLocale.current.identifier : APIConstants.usEnglishLanguage
    }

    func downloadImage(cityId: String, imageName: String, onSuccess: @escaping ((UIImage?) -> Void)) {

        let imageUrl = String(format: APIConstants.openWeatherImageUrl, imageName)

        let imageDestination: DownloadRequest.DownloadFileDestination = { _, _ in
            let cacheUrl = CacheService.temporaryUrl
            let imageName = String(format: CacheConstants.imageCacheName, cityId)
            let imageUrl = cacheUrl.appendingPathComponent(imageName)

            return (imageUrl, [.removePreviousFile, .createIntermediateDirectories])
        }

        Alamofire.download(imageUrl, to: imageDestination).validate().responseData { response in
            switch response.result {
            case .success:
                if let data = response.value, let image = UIImage(data: data) {
                    onSuccess(image)
                }
                else {
                    print("Could not retrieve image data from \(imageUrl)")
                    onSuccess(nil)
                }
            case let .failure(error):
                print("Image API error: \(error.localizedDescription)")
                onSuccess(nil)
            }
        }
    }
}
