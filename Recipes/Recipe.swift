//
//  Recipe.swift
//  Recipes
//
//  Created by Karthik S V on 07/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Recipe: Object {
    
    static var counter = 0
    dynamic var Id = 0
    dynamic var title: String!
    dynamic var timeNeeded: String!
    var ingredients = List<Ingredients>()
    var directions = List<Ingredients>()
    dynamic var category: String = "South Indian"
    
    convenience init(withTitle title:String, timeNeeded: String, ingredients: List<Ingredients>, directions: List<Ingredients>, Id: Int)
    {
        self.init()
        self.Id = Id
        self.title = title
        self.timeNeeded = timeNeeded
        self.ingredients = ingredients
        self.directions = directions
        
    }
    
    override class func primaryKey() -> String? {
        return "Id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["timeNeeded","title"]
    }
    
    
    
    
}
