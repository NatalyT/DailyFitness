//
//  Equipments.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

private let equipmentURL = "https://wger.de/api/v2/equipment/?format=json"

struct Item: Codable {
    var id: Int?
    var name: String?
}

struct Equipment: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Item]?
    
    static func fetchJson() -> Equipment? {
        if let url = URL(string: equipmentURL) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Equipment.self, from: data)
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

