//
//  recipeDetails+ingrediantsTable.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/7/21.
//

import Foundation
import UIKit

extension RecipeDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedRecipe.ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingrediantCell = ingrediantsTableView.dequeueReusableCell(withIdentifier: "IngrediantCell")
        ingrediantCell?.textLabel?.text = selectedRecipe.ingredientLines?[indexPath.row]
        return ingrediantCell!
    }
    
    
}
