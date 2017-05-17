//
//  ViewController.swift
//  Recipes
//
//  Created by Karthik S V on 07/05/17.
//  Copyright © 2017 SV. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
class RecipeListViewController: UIViewController{
    
    @IBOutlet weak var recipeTableView: UITableView!
    var recipes: Results<Recipe>!
    var selectedRecipe: Recipe!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
//        let recipeOne = Recipe(withTitle: "Masala Dosa", timeNeeded: "2 mins", ingredients: ["Bread","Eggs","Eggs","Milk"], directions: ["Bread","Eggs","Eggs","Milk"])
//        recipes.append(recipeOne)
        
        
        let realm = try! Realm()
        recipes = realm.objects(Recipe.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let recipeDetailViewController = segue.destination as? RecipeDetailsViewController {
                if let indexPath = recipeTableView.indexPath(for: sender as! UITableViewCell){
                    recipeDetailViewController.recipe  = recipes[indexPath.row]
                    recipeDetailViewController.fromDetailsTableView = true
                    recipeDetailViewController.title = recipes[indexPath.row].title
                    recipeDetailViewController.delegate = self
                    
                }
                
            }
            
            
        }
        else if segue.identifier == "addDetail" {
            
            if let recipeDetailViewController = segue.destination as? RecipeDetailsViewController {
                //recipeDetailViewController.recipe  = recipes[indexPath.row]
                recipeDetailViewController.fromDetailsTableView = false
                recipeDetailViewController.title = "Add Recipe"
                recipeDetailViewController.delegate = self
                
                
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editTableView(_ sender: Any) {
        
        recipeTableView.isEditing = !recipeTableView.isEditing
    }
    
    
    
}

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeCellTableViewCell{
            
            cell.updateUI(recipe: recipes[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        //var recipes = self.recipes as! Array<Any>
//        let itemToMove = recipes
//        
//        
//        
//        //try! recipes.realm!.write {
//            recipes.realm!.beginWrite()
//           // recipes.realm!.beginWriteTransaction()
//            recipes
//            recipes.removeObjectAtIndex(UInt(sourceIndexPath.row))
//            itemToMove.insertObject(itemToMove, atIndex: UInt(destinationIndexPath.row))
//            recipes.realm!.commitWrite()
//        
////        recipes.remove(at: sourceIndexPath.row)
////        recipes.insert(itemToMove, at: destinationIndexPath.row)
//    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            try! recipes.realm!.write {
                recipes.realm!.delete(recipes[indexPath.row])
            }
            recipeTableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}

extension RecipeListViewController: RecipeProtocol{
    func saveAndReloadTheTable(recipe: Recipe){
       // recipes.append(recipe)
    }
}

