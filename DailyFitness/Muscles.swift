//
//  Muscles.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

private let musclesURL = "https://wger.de/api/v2/muscle/?format=json"

struct Muscle: Codable {
    var id: Int?
    var name: String?
    var is_front: Bool?
}

struct Muscles: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Muscle]?
    
    static func fetchJson() -> Muscles? {
        if let url = URL(string: musclesURL) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Muscles.self, from: data)
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
