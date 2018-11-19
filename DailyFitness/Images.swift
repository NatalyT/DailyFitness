//
//  Images.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

private let imagesURL = "https://wger.de/api/v2/exerciseimage/?format=json&exercise="

struct Image: Codable {
    var id: Int?
    var license_author: String?
    var status: String?
    var image: String?
    var is_main: Bool?
    var license: Int?
    var exercise: Int?
}

struct Images: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Image]?
    
    static func fetchJson(exerciseId: Int) -> Images? {
        let urlString = imagesURL + String(exerciseId)
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Images.self, from: data)
                return jsonData
            } catch DecodingError.dataCorrupted {
                print("Data corrupted")
            } catch {
                print("Fetching JSON Error")
            }
        }
        return nil
    }
}

