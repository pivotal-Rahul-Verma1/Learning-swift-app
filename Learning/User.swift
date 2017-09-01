//
//  File.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-14.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//
import Foundation
import Firebase

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

