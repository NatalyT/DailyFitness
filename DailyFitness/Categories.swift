//
//  Equipment.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

private let categoryURL = "https://wger.de/api/v2/exercisecategory/?format=json"

struct Category: Codable {
    var id: Int?
    var name: String?
}

struct Categories: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Category]?
    
    static func fetchJson() -> Categories? {
        if let url = URL(string: categoryURL) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Categories.self, from: data)
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
