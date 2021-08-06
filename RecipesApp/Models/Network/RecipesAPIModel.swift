//
//  RecipesAPIModel.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation
import Alamofire



class RecipesAPIModel {
    
    private (set) var recipesApiResponse: RecipesApiResponse?
    
    
     func fetchAllRecipes(completion : @escaping ([recipeObject]?, Error?)->()){
        
        AF.request(URLs.allRecipesUrl)
            .validate()
            .responseDecodable(of: RecipesApiResponse.self) { [weak self] (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let urlResponse = response.value else { return }
                    self!.recipesApiResponse = urlResponse
                    let recipesData = self!.recipesApiResponse?.hits
                    
                    
                    completion(recipesData ,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}
