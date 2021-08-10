//
//  RecipesViewModel.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation

class RecipesViewModel {
    private (set) var currentViewedRecipesList: [recipeObject]?{
        didSet{
            self.bindRecipesViewModelToView()
        }
    }
    
    private var allRecipesFromAPI: [recipeObject]?{
        didSet{
            setViewedRecipesToAllRecipes()
        }
    }
    
    var recipesModel: RecipesAPIModel?
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindRecipesViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    var bindNextPageOfRecipesFromViewModelToView: (()->()) = {}
    
    
    
    
    
    init() {
        
        self.recipesModel = RecipesAPIModel()
       
    }
    
    
    func fetchallRecipesDataFromAPI (of searchWord: String)-> String{
        
        let searchWordAfterTrimming = setSearchWordToAPIPattern(text: searchWord)
        if Connectivity.isConnectedToInternet{
        
        recipesModel?.fetchAllRecipes(of: searchWordAfterTrimming,completion: { (recipesList, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                if recipesList?.count == 0 {
                    
                    let message = ConstantData.noSearchResultsFoundErrorString
                    self.showError = message
                    
                }else{
                    self.allRecipesFromAPI = recipesList
                }
               
                
            }
           
        })
        }else{
            let message = ConstantData.noConnectionMessage
            self.showError = message
        }
        return searchWordAfterTrimming
    }
    
    
    func fetchNextPageOfRecipes(){
        if Connectivity.isConnectedToInternet{
        recipesModel?.fetchNextPageOfRecipes(completion: { [weak self] (recipesList, error) in
            if let error: Error = error{
                let message = error.localizedDescription
                self?.showError = message
            }else{
                self?.currentViewedRecipesList?.append(contentsOf: recipesList!)
                self?.bindNextPageOfRecipesFromViewModelToView()
            }
            
        })
        }else{
            let message = ConstantData.noConnectionMessage
            self.showError = message
        }
    }
    
    func fetchFilterRecipesFromAPI(filterIndex: Int){
        let (_, filterWord) = ConstantData.filterOptions[filterIndex]
        if Connectivity.isConnectedToInternet{
        recipesModel?.fetchRecipesForFilter(filterWord, completion:{ [weak self] (filterRecipesList, error) in
            if let error: Error = error{
                let message = error.localizedDescription
                self?.showError = message
            }else{
                self?.currentViewedRecipesList = filterRecipesList
                
            }
            
        })
        }else{
            let message = ConstantData.noConnectionMessage
            self.showError = message
        }
    }
    
    func setViewedRecipesToAllRecipes(){
        currentViewedRecipesList = allRecipesFromAPI
    }
    
    
    
    private func setSearchWordToAPIPattern(text: String)-> String{
        var returnText = text.replacingOccurrences(of: ".", with: "")
        returnText = returnText.trimmingCharacters(in: .whitespaces)
        returnText = returnText.replacingOccurrences(of: " ", with: "-")
        return returnText
    }
    
    static func getLastSavedWord()->String{
        return (RecipesAPIModel.savedSearchWord)!
    }
}
