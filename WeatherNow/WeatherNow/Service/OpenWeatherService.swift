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

    func getData(lat: String, lon: String, completion: @escaping (Weather?) -> Void) {

        guard let url = URL(string: APIConstants.url) else {
            completion(nil)
            return
        }

        let language = getLanguage()

        let params: [String:String] = ["lat": lat,
                                       "lon": lon,
                                       "appid": "",
                                       "units": "metric",
                                       "lang": language]

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
                    completion(weather)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure:
                print(response.error?.localizedDescription ?? "Error fetching data from API")
                completion(nil)
            }
        }
    }

    func getLanguage() -> String {
        guard let collatorId = NSLocale.current.collatorIdentifier else {
            return "en-US"
        }

        return NSLocale.preferredLanguages.contains(collatorId) ? NSLocale.current.identifier : "en-US"
    }
}
