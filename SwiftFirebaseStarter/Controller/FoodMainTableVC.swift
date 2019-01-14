//
//  FoodMainTableVC.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase

class FoodMainTableVC: UITableViewController {
    
    var items: [FoodItem] = []
    let foodItemsReference = Database.database().reference(withPath: "food-items")
    
    @IBOutlet var foodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Get Child Values
        //        foodItemsReference.child("pizza").observe(.value) { snapshot in
        //            let values = snapshot.value as! [String:AnyObject]
        //            let foodName = values["foodName"] as! String
        //            let shopName = values["shopName"] as! String
        //            let completed = values["completed"] as! Bool
        //            print("chhh", foodName,shopName,completed)
        //        }
        
        //Observe for value changed
        
        //        foodItemsReference.observe(.value) { (snapshot) in
        //            var newItems : [FoodItem] = []
        //            for item in snapshot.children{
        //                let foodItem = FoodItem(snapshot: item as! DataSnapshot)
        //                newItems.append(foodItem)
        //            }
        //            self.items = newItems
        //            self.foodTableView.reloadData()
        //        }
        //
        foodItemsReference.observe(.value, with: {
            snapshot in
            print(snapshot)
        })
        
        
        foodItemsReference.queryOrdered(byChild: "completed").observe(.value) { snapshot in
            var newItems: [FoodItem] = []
            for item in snapshot.children{
                let foodItem = FoodItem(snapshot: item as! DataSnapshot)
                newItems.append(foodItem)
            }
            self.items = newItems
            self.foodTableView.reloadData()
        }
        
    }
    
    @IBAction func addFoodItemTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Food Item",
                                      message: "Add Food And your favourite Shop",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Add Food Name"
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Add Shop Name"
        }
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let textFieldFoodName = alert.textFields![0]
                                        let textFieldShopName = alert.textFields![1]
                                        
                                        let foodItem = FoodItem(foodName: textFieldFoodName.text!,
                                                                shopName: textFieldShopName.text!,
                                                                completed: false)
                                        self.items.append(foodItem)
                                        self.foodTableView.reloadData()
                                        
                                        let foodItemRef = self.foodItemsReference.child(textFieldFoodName.text!.lowercased())
                                        let values: [String: Any] = [ "foodName": textFieldFoodName.text!, "shopName": textFieldShopName.text!, "completed": false]
                                        foodItemRef.setValue(values)
                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let FoodItem = items[indexPath.row]
        cell.textLabel?.text = FoodItem.foodName
        cell.detailTextLabel?.text = FoodItem.shopName
        
        toggleCellCheckbox(cell, isCompleted: FoodItem.completed)
        
        return cell
    }
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ////Update Data
        ////
        ////        let values: [String:Any] = ["foodName" : "Ahillll"]
        ////        foodItem.ref?.updateChildValues(values)
        //
        //        foodTableView.reloadData()
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        var foodItem = items[indexPath.row]
        let toggledCompletion = !foodItem.completed
        
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        foodItem.completed = toggledCompletion
        foodItem.ref?.updateChildValues(["completed" : toggledCompletion])
        
        foodTableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let foodItem = items[indexPath.row]
            //foodItem.ref?.removeValue()
            foodItem.ref?.setValue(nil)
            
            items.remove(at: indexPath.row)
            foodTableView.reloadData()
            
        }
    }
}



