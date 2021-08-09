//
//  URLs.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation

struct URLs{
    static func getSearchRecipes(of searchWord: String)-> String{
        "https://api.edamam.com/api/recipes/v2?type=public&q=\(searchWord)&app_id=666f2705&app_key=e17eaf71640dd3d1e2838fe865866652%09"
    }
    
    
    static func getFilterURL(for searchWord:String, with filterString: String)-> String{
        
        "https://api.edamam.com/api/recipes/v2?type=public&q=\(searchWord)&app_id=666f2705&app_key=e17eaf71640dd3d1e2838fe865866652&health=\(filterString)"
        
    }
    
    
    
}
