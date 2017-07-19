//
//  FirebaseManager.swift
//  Recipes
//
//  Created by Karthik S V on 16/07/17.
//  Copyright © 2017 SV. All rights reserved.
//

import Foundation
import FirebaseDatabase


let DB = FIRDatabase.database().reference()

class FirebaseManager {
    
    static let fm = FirebaseManager()
    
    private let _USER_DB = DB.child("users")
    private let _RECIPE_DB = DB.child("recipes")
    
    var USER_DB: FIRDatabaseReference {
        return _USER_DB
    }
    
    
    func createDatabaseUser(uid: String, userData: Dictionary<String, String>) {
        USER_DB.child(uid).updateChildValues(userData)
    }
}
