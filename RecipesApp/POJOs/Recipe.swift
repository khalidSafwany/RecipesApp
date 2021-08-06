//
//  Recipe.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import Foundation

struct Recipe: Codable {
    private (set) var uri: String?
    private (set) var label: String?
    private (set) var image: String?
    private (set) var source: String?
    private (set) var url: String?
    private (set) var shareAs: String?
    private (set) var yield: Int?
    private (set) var dietLabels: [String]?
    private (set) var healthLabels: [String]?
    private (set) var cautions: [String]?
    private (set) var ingredientLines: [String]?
    
}
