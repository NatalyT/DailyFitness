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
            let newExercise = ExerciseInfo(id: ex.id ?? 0, category: category?.name ?? "", name: ex.name ?? "", equipment: getEquipmentList(equipment: ex.equipment!), muscles: getMusclesList(muscles: ex.muscles!), imageURL: "")
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExerciseTableViewCell
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
