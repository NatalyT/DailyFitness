//
//  Exercises.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    var id: Int?
    var license_autor: String?
    var status: String?
    var description: String?
    var name: String?
    var name_original: String?
    var creation_date: String?
    var uuid: String?
    var license: Int?
    var category: Int?
    var language: Int?
    var muscles: [Int]?
    var muscles_secondary: [Int]?
    var equipment: [Int]?
}

struct Exercises: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Exercise]
    
    static func fetchJson(exercisesURL: String) -> Exercises? {
        if let url = URL(string: exercisesURL) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Exercises.self, from: data)
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
