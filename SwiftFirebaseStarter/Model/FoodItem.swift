//
//  FoodItem.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

struct FoodItem {
    
    var foodName: String
    var shopName: String
    var completed: Bool
    
    init(foodName: String , shopName: String, completed: Bool) {
        self.foodName = foodName
        self.shopName = shopName
        self.completed = completed
    }
    
}
