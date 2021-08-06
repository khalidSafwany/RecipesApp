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
    
    
    
    
    init() {
        
        self.recipesModel = RecipesAPIModel()
       
    }
    
    
    func fetchallRecipesDataFromAPI (){
        
        recipesModel?.fetchAllRecipes(completion: { (recipesList, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.allRecipesFromAPI = recipesList
                
            }
           
        })
    }
    
    func setViewedRecipesToAllRecipes(){
        currentViewedRecipesList = allRecipesFromAPI
    }
}
