//
//  CacheService.swift
//  WeatherNow
//
//  Created by Arthur Silva on 21/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import Foundation
import UIKit

class CacheService {

    static let temporaryUrl = URL(fileURLWithPath: NSTemporaryDirectory())

    func saveData(fileName: String, data: Data) {

        let fileUrl = CacheService.temporaryUrl.appendingPathComponent(fileName, isDirectory: false)

        do {
            try data.write(to: fileUrl)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func getAllFilesNames() -> [String]? {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: CacheService.self.temporaryUrl.path)
        } catch {
            print("Error getting the cached files names: \(error.localizedDescription)")
            return nil
        }
    }

    func loadWeatherData() -> Weather? {
        let allnames = getAllFilesNames()

        let images = allnames?.filter({ $0.contains(CacheConstants.imageNameFlag) })
        let weathers = allnames?.filter({ !$0.contains(CacheConstants.imageNameFlag) && !$0.contains(CacheConstants.appleCacheName) })

        guard let weatherFileName = weathers?.first, let imageFileName = images?.first else { return nil }

        do {
            let weatherData = try Data(contentsOf: CacheService.self.temporaryUrl.appendingPathComponent(weatherFileName, isDirectory: false))
            let owData = try JSONDecoder().decode(OWData.self, from: weatherData)
            var weather = Weather(data: owData)

            let imageData = try Data(contentsOf: CacheService.self.temporaryUrl.appendingPathComponent(imageFileName, isDirectory: false))
            let image = UIImage(data: imageData)
            weather.image = image

            return weather
        } catch {
            print("Error loading or decoding cache data: \(error.localizedDescription)")
            return nil
        }
    }

    func deleteAllFiles() {
        guard let filesNames = getAllFilesNames() else { return }

        let fileManager = FileManager.default

        do {
            for fileName in filesNames {
                let fileUrl = CacheService.self.temporaryUrl.appendingPathComponent(fileName, isDirectory: false)
                try fileManager.removeItem(at: fileUrl)
            }
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
