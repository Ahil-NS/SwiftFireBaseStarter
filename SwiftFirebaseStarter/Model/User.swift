//
//  User.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
