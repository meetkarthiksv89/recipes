//
//  InstructionTableViewCell.swift
//  Recipes
//
//  Created by Karthik S V on 07/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var instructionDetail: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateUI(withDetail detail: Ingredients, setEdititng editing: Bool)
    {
        instructionDetail.text = detail.ingredient
        instructionDetail.sizeToFit()
        
        if editing {
            instructionDetail.isEditable = false
        }
        else {
            instructionDetail.isEditable = true
        }
        
    }
    
}
