//
//  URLs.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation

struct URLs{
    private (set) static var allRecipesUrl = "https://api.edamam.com/api/recipes/v2?type=public&q=heavy-cream&app_id=666f2705&app_key=e17eaf71640dd3d1e2838fe865866652%09"
    
    static func getFilterURL(for filterString: String)-> String{
        
        "https://api.edamam.com/api/recipes/v2?type=public&q=meat&app_id=666f2705&app_key=e17eaf71640dd3d1e2838fe865866652&health=\(filterString)"
        
    }
    
    
    
}
