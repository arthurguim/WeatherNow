//
//  CacheService.swift
//  WeatherNow
//
//  Created by Arthur Silva on 21/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import Foundation

class CacheService {

    let temporaryUrl = URL(fileURLWithPath: NSTemporaryDirectory())

    func saveData(fileName: String, data: Data) {

        let fileUrl = temporaryUrl.appendingPathComponent(fileName, isDirectory: false)

        do {
            try data.write(to: fileUrl)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func getAllFilesNames() -> [String]? {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: self.temporaryUrl.path)
        } catch {
            print("Error getting the cached files names: \(error.localizedDescription)")
            return nil
        }
    }

    func loadData() -> Data? {
        guard let fileName = getAllFilesNames()?.first else { return nil }

        do {
            let data = try Data(contentsOf: temporaryUrl.appendingPathComponent(fileName, isDirectory: false))
            return data
        } catch {
            print("Error loading data: \(error.localizedDescription)")
            return nil
        }
    }

    func deleteAllFiles() {
        guard let filesNames = getAllFilesNames() else { return }

        let fileManager = FileManager.default

        do {
            for fileName in filesNames {
                let fileUrl = temporaryUrl.appendingPathComponent(fileName, isDirectory: false)
                try fileManager.removeItem(at: fileUrl)
            }
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
