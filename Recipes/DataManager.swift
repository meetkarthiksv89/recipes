//
//  DataManager.swift
//  Recipes
//
//  Created by Karthik S V on 12/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import Foundation

class DataManager {
    
    public class func loadJSONAndParse(_ success: @escaping ((_ data: Data) -> Void)) {
        
        let filePath = Bundle.main.path(forResource: "recipeJSON", ofType: "json")
        let fileData = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        
        success(fileData)
        
        
    }
}
