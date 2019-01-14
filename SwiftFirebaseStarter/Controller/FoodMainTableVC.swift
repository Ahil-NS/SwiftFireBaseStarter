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
    let groceryItemsReference = Database.database().reference(withPath: "food-items")
    
    @IBOutlet var foodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                                        
                                        let groceryItem = FoodItem(foodName: textFieldFoodName.text!,
                                                                   shopName: textFieldShopName.text!,
                                                                   completed: false)
                                        self.items.append(groceryItem)
                                        self.foodTableView.reloadData()
                                        
                                        let groceryItemRef = self.groceryItemsReference.child(textFieldFoodName.text!.lowercased())
                                        let values: [String: Any] = [ "foodName": textFieldFoodName.text!, "shopName": textFieldShopName.text!, "completed": false]
                                        groceryItemRef.setValue(values)
                                        
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
        return cell
    }
}



