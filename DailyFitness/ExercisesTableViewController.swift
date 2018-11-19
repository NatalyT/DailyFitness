//
//  ExercisesTableViewController.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

struct ExerciseInfo {
    var id: Int
    var category: String
    var name: String
    var equipment: String
    var muscles: String
    var imageURL: String
}

class ExercisesTableViewController: UITableViewController {
    
    private let reuseIdentifier = "exerciseCell"
    var placeholder = UIImage(named: "placeholder")
    
    var musclesList = [Muscle]()
    var categoriesList = [Category]()
    var equipmentList = [Item]()
    var exercisesList = [Exercise]()
    var exercises = [ExerciseInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJSONData()
        getExerciseInfo()
    }
    
    func fetchJSONData() {
        if let m = Muscles.fetchJson() {
            musclesList = m.results ?? []
        }
        //        print(musclesList)
        
        if let c = Categories.fetchJson() {
            categoriesList = c.results ?? []
        }
        //        print(categoriesList)
        
        if let e = Equipment.fetchJson() {
            equipmentList = e.results ?? []
        }
        //        print(equipmentList)
        
        if let ex = Exercises.fetchJson() {
            exercisesList = ex.results
        }
//        print(exercisesList)
    }
    
    func getExerciseInfo() {
        for ex in exercisesList {
            let category = categoriesList.first (where: { $0.id == ex.category })
            let newExercise = ExerciseInfo(id: ex.id ?? 0, category: category?.name ?? "", name: ex.name ?? "", equipment: getEquipmentList(equipment: ex.equipment!), muscles: getMusclesList(muscles: ex.muscles!), imageURL: getImageURL(exerciseId: ex.id!))
            exercises.append(newExercise)
        }
        print(exercises)
    }
    
    private func getMusclesList(muscles: [Int]) -> String {
        var muscleNamesString = ""
        for muscle in muscles {
            let m = musclesList.first (where: { $0.id == muscle})
            muscleNamesString.append(contentsOf: (m?.name)!)
            muscleNamesString.append(contentsOf: ", ")
        }
        return String(muscleNamesString.dropLast(2))
    }
    
    private func getEquipmentList(equipment: [Int]) -> String {
        var equipmentNamesString = ""
        for equipmentItem in equipment {
            let e = equipmentList.first (where: { $0.id == equipmentItem })
            equipmentNamesString.append(contentsOf: (e?.name)!)
            equipmentNamesString.append(contentsOf: ", ")
        }
        return String(equipmentNamesString.dropLast(2))
    }
    
    private func getImageURL(exerciseId: Int) -> String {
        if let images = Images.fetchJson(exerciseId: exerciseId) {
            if images.results!.count > 0 {
                return images.results![0].image ?? ""
            }
        }
        return ""
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExerciseTableViewCell
        cell.categoryLabel.text = exercises[indexPath.row].category
        cell.nameLabel.text = exercises[indexPath.row].name
        cell.musclesLabel.text = exercises[indexPath.row].muscles
        cell.equipmentLabel.text = exercises[indexPath.row].equipment
        cell.exerciseImageView.loadAsyncFrom(url: exercises[indexPath.row].imageURL, placeholder: placeholder)
        return cell
    }
    
}
