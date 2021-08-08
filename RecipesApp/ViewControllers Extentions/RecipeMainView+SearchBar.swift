//
//  RecipeMainView+SearchBar.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/8/21.
//

import Foundation
import UIKit

extension RecipesMainViewController: UISearchBarDelegate{
   
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if   range.location == 0, text.first == " "{
            return false
        }
        return text.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")) != nil
    }
}
