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
        if tableView.tag == 3{
            return self.recipesList.count
        }
        else if tableView.tag == 2{
            return self.searchRecommendationObject.getRecommendations().count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 3{
       let recipeCell = recipesTableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableCell
        recipeCell.recipeImageView.sd_setImage(with: URL(string: (recipesList[indexPath.row].recipe?.image)!), completed: nil)
        recipeCell.recipeName.text = recipesList[indexPath.row].recipe?.label
        recipeCell.recipeSource.text = recipesList[indexPath.row].recipe?.source
        recipeCell.recipeHealthLabels.text = recipesList[indexPath.row].recipe?.dietLabels?.joined(separator: ", ")
        
            return recipeCell
            
        }
        else{
            let suggesionCell = suggestionsTableView.dequeueReusableCell(withIdentifier: "suggesionCell", for: indexPath)
            suggesionCell.textLabel?.text = searchRecommendationObject.getRecommendations()[indexPath.row]
            return suggesionCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 3{
        return 114
        }
        else {return 30}
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 3{
        
        if indexPath.row == recipesList.count - 2{
            fetchNextPageOfRecipes()
        }
        lastViewedRow = indexPath.row
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 3{
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showRecipeDetails", sender: self)
        }
        else{
          
                recipesSearchBar.text = searchRecommendationObject.getRecommendations()[indexPath.row]
                startSearch(searchBar: recipesSearchBar)
            
        }
    }
    
    
    
}
