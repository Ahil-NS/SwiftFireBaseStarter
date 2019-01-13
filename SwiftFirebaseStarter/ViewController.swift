//
//  ViewController.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/13/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let groceryItemsReference = Database.database().reference(withPath: "grocery-items")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let groceryItemRef = self.groceryItemsReference.child("Pizza")
        let values: [String: Any] = [ "name": "Pizza", "addedByUser": "eahilendran@gmail.com", "completed": false]
        groceryItemRef.setValue(values)
        
    }


}

