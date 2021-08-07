//
//  RecipesMainView+tableExtension.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation
import UIKit
import SDWebImage

extension RecipesMainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.recipesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let recipeCell = recipesTableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableCell
        recipeCell.recipeImageView.sd_setImage(with: URL(string: (recipesList[indexPath.row].recipe?.image)!), completed: nil)
        recipeCell.recipeName.text = recipesList[indexPath.row].recipe?.label
        recipeCell.recipeSource.text = recipesList[indexPath.row].recipe?.source
        recipeCell.recipeHealthLabels.text = recipesList[indexPath.row].recipe?.dietLabels?.joined(separator: ", ")
        
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recipesList.count - 2{
            fetchNextPageOfRecipes()
        }
        lastViewedRow = indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showRecipeDetails", sender: self)
    }
    
    
    
}
