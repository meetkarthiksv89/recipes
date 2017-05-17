//
//  Ingredients.swift
//  Recipes
//
//  Created by Karthik S V on 12/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Ingredients: Object {
    
    dynamic var ingredient: String! = nil
    
    convenience init(_ ingredient: String?){
        self.init()
        if let ingredient = ingredient {
            
            self.ingredient = ingredient
        }
    }
}
