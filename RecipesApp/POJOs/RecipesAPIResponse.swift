//
//  RecipesAPIResponse.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation
struct RecipesApiResponse: Codable{
    private (set) var from: Int?
    private (set) var to: Int?
    private (set) var count: Int?
    private (set) var _links: _links?
    private (set) var hits:[recipeObject]?
}

struct recipeObject: Codable{
    private(set) var recipe: Recipe?
}

struct hits:Codable{
    private (set) var recipesList: [Recipe]?
}

struct _links: Codable{
    private (set) var next: next?
}

struct next: Codable{
    private (set) var href: String?
    private (set) var title: String?
}
