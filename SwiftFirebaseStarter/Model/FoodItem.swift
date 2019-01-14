//
//  FoodItem.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation
import Firebase

struct FoodItem {
    
    let foodName: String
    let shopName: String
    var completed: Bool
    let ref: DatabaseReference?
    let key: String
    
    
    init(foodName: String , shopName: String, completed: Bool, key: String = "") {
        self.key = key
        self.foodName = foodName
        self.shopName = shopName
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot : DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        foodName = snapshotValue["foodName"] as! String
        shopName = snapshotValue["shopName"] as! String
        completed = snapshotValue["completed"] as! Bool
    }
    
}
