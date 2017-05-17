//
//  RecipeCellTableViewCell.swift
//  Recipes
//
//  Created by Karthik S V on 07/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import UIKit

class RecipeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var timeRequired: UILabel!
    var recipe: Recipe!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeTitle.text = "asdf"
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateUI(recipe: Recipe){
        
        self.recipeTitle.text = recipe.title
        timeRequired.text = recipe.timeNeeded!
        
    }
    
}
