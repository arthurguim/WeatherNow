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

    func getData(completion: @escaping (OWData?) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else {
            completion(nil)
            return
        }

        let params: [String:String] = ["q": "Campinas",
                                       "appid": "",
                                       "units": "metric",
                                       "lang": "en_us"]

        Alamofire.request(url, method: .get, parameters: params).validate().responseData { response in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    completion(nil)
                    return
                }

                do {
                    let owData = try JSONDecoder().decode(OWData.self, from: data)
                    completion(owData)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure:
                print(response.error?.localizedDescription)
                completion(nil)
            }
        }
    }
}
