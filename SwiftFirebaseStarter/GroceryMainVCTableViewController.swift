//
//  GroceryMainVCTableViewController.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase

class FoodMainVCTableViewController: UITableViewController {

    let groceryItemsReference = Database.database().reference(withPath: "food-items")
    
    
    @IBOutlet var FoodTableView: UITableView!
    var item : [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func AddGroceryButoonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add your favorite Food Name and Shop", message: "Add your favorite Food Name and Shop", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add Food Item"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Add Shop Name"
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textFieldFoodName = alert.textFields![0]
            let textFieldShopName = alert.textFields![1]
        
            let groceryItem = FoodItem(foodName: textFieldFoodName.text!, shopName: textFieldShopName.text!, completed: true)
            
            self.item.append(groceryItem)
            self.FoodTableView.reloadData()
            
            let groceryItemRef = self.groceryItemsReference.child(textFieldFoodName.text!)
            
            let values: [String: Any] = [ "foodName": textFieldFoodName.text!, "shopName": textFieldShopName.text!, "completed": false]
            groceryItemRef.setValue(values)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = item[indexPath.row].foodName
        cell.detailTextLabel?.text = item[indexPath.row].shopName
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




}
