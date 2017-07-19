//
//  RecipeDetailsViewController.swift
//  Recipes
//
//  Created by Karthik S V on 07/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import UIKit
import RealmSwift

protocol RecipeProtocol {
    func saveAndReloadTheTable(recipe: Recipe)
}

class RecipeDetailsViewController: UIViewController{
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var timeNeeded: UITextField!
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var instructionTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var fromDetailsTableView = false
    
    weak var delegate: RecipeListViewController?
    var recipe: Recipe!
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionTableView.delegate = self
        instructionTableView.dataSource = self
        instructionTableView.estimatedRowHeight = 70
        instructionTableView.rowHeight = UITableViewAutomaticDimension
        updateUIComponents()
        
        
    }
    @IBOutlet weak var close: UIButton!
    @IBAction func closeWindow(_ sender: Any) {
        if timeNeeded.text != nil, recipeTitle.text != nil {
            
            let ingredients = List<Ingredients>()
            let directions = List<Ingredients>()
            for section in 0..<instructionTableView.numberOfSections {
                
                for row in 0..<instructionTableView.numberOfRows(inSection: section) {
                    
                    let indexPath = IndexPath(row: row, section: section)
                    let cell = instructionTableView.cellForRow(at: indexPath) as! InstructionTableViewCell
                    if section == 0 {
                        ingredients.append(Ingredients(cell.instructionDetail.text!))
                    }
                    if section == 1 {
                        directions.append(Ingredients(cell.instructionDetail.text!))
                    }
                    
                    // do what you want with the cell
                    
                }
            }
    
            let realm = try! Realm()
            let checkForRecipe = realm.objects(Recipe.self).filter("title = %@", recipeTitle.text!)
            
            if checkForRecipe.count > 0 {
                print("")
            }
            else{
                let Id = Recipe.counter + 1
                let recipe = Recipe(withTitle: recipeTitle.text!, timeNeeded: timeNeeded.text!, ingredients: ingredients, directions: directions, Id: Id)
                //FirebaseManager.saveRecipe(recipe)
                try! realm.write {
                    realm.add(recipe)
                }
                //delegate?.saveAndReloadTheTable(recipe: recipe)
                dismiss(animated: true, completion: nil)
                
            }
            
        }
        //delegate?.saveAndReloadTheTable(recipe: <#T##Recipe#>)
        
    }
    func updateUIComponents(){
        
        if let recipe = recipe {
            self.timeNeeded.text = recipe.timeNeeded
            self.recipeTitle.text = recipe.title
        }
        if fromDetailsTableView {
            timeNeeded.isUserInteractionEnabled = false
            recipeTitle.isUserInteractionEnabled = false
            close.isHidden = true
            saveButton.isHidden = true
            
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = instructionTableView.dequeueReusableCell(withIdentifier: "instructionDetail") as? InstructionTableViewCell{
            
            cell.instructionDetail.delegate = self
            if indexPath.section == 0{
                if let recipe = recipe {
                    cell.updateUI(withDetail: recipe.ingredients[indexPath.row] , setEdititng: fromDetailsTableView)
                }
                else{
                    let ingredient = Ingredients("Add detail")
                    cell.updateUI(withDetail: ingredient, setEdititng: fromDetailsTableView)
                    
                }
            }
            if indexPath.section == 1{
                if let recipe = recipe {
                    cell.updateUI(withDetail: recipe.directions[indexPath.row], setEdititng: fromDetailsTableView)
                }
                else{
                    let ingredient = Ingredients("Add detail")

                    cell.updateUI(withDetail: ingredient, setEdititng: fromDetailsTableView)
                    
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let recipe = recipe {
            if section == 0 {
                return recipe.ingredients.count
            }
            else if section == 1 {
                return recipe.directions.count
            }
        }
        return 4
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Ingredients"
        }
        else {
            return "Directions"
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if indexPath.section == 0 {
                recipe.ingredients.remove(at: indexPath.row)
            }
            else if indexPath.section == 1 {
                recipe.directions.remove(at: indexPath.row)
            }
            instructionTableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}

extension RecipeDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = instructionTableView.contentOffset
        UIView.setAnimationsEnabled(false)
        instructionTableView.beginUpdates()
        instructionTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        instructionTableView.setContentOffset(currentOffset, animated: false)
    }
    
}
