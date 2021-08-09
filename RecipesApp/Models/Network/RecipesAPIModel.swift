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
    private (set) var savedSearchWord: String?
    
    
    func fetchAllRecipes(of searchWord:String, completion : @escaping ([recipeObject]?, Error?)->()){
       
        AF.request(URLs.getSearchRecipes(of: searchWord))
            .validate()
            .responseDecodable(of: RecipesApiResponse.self) { [weak self] (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let urlResponse = response.value else { return }
                   
                    let recipesData = urlResponse.hits
                    if (recipesData?.count)! == 0{
                        completion([recipeObject](), nil)
                        return
                    }
                    self!.savedSearchWord = searchWord
                    self!.recipesApiResponse = urlResponse
                    completion(recipesData ,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
    
    func fetchNextPageOfRecipes(completion: @escaping ([recipeObject]?, Error?)->()){
        if let nextPageURLString = recipesApiResponse?._links?.next?.href{
            if recipesApiResponse?._links?.next?.title != ""{
        AF.request(nextPageURLString).validate()
            .responseDecodable(of: RecipesApiResponse.self){ [weak self] (response) in
                
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
    }
    
    
    
    func fetchRecipesForFilter(_ filterString: String, completion: @escaping ([recipeObject]?, Error?)->()){
        let filterURL = URLs.getFilterURL(for: self.savedSearchWord!, with: filterString)
        
        AF.request(filterURL).validate()
            .responseDecodable(of: RecipesApiResponse.self){ [weak self] (response) in
                
                switch response.result {
                case .success( _):
                    
                    guard let urlResponse = response.value else { return }
                    self!.recipesApiResponse = urlResponse
                    let filterRecipesData = self!.recipesApiResponse?.hits
                    
                    
                    completion(filterRecipesData ,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
                
            }
        
    }
}
