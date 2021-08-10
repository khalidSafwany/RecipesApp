//
//  SearchRecommendationsViewModel.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/10/21.
//

import Foundation
class SearchRecommendationsViewModel {
    
    var searchRecommendationsObject: RecommendationStack?{
        didSet{
            bindRecomendationsToMainView()
        }
    }
    
    var recommendationsModel: SearchRecommendationModel?
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindRecomendationsToMainView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    init() {
        recommendationsModel = SearchRecommendationModel()
    }
    
    func fetchSearchRecommendations(){
        recommendationsModel?.fetchRecommendationsFromCoreData(completion: { (recomendationObject, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                self.searchRecommendationsObject = recomendationObject
                }
               
                
            
           
        })

    }
}
