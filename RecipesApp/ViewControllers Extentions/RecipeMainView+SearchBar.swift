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
        if text == "\n"{return true}
        return text.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")) != nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearch(searchBar: searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
//        showSuggestionsTableView()
       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
    }
    
    func startSearch(searchBar: UISearchBar){
        if let searchText = searchBar.text{
            self.showSpinner()
        let lastSearchWord = recipesViewModel?.fetchallRecipesDataFromAPI(of: searchText)
            searchRecommendationObject.push(lastSearchWord ?? "")
            removeSuggestionsTableView()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        removeSuggestionsTableView()
    }
}
