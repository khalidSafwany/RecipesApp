//
//  ContsntsNumbers.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/7/21.
//

import Foundation

struct ConstantData{
    static let filterOptions = [("All","all"), ("Alcohol Free","alcohol-free"), ("Celery Free", "celery-free"), ("Crustacean Free", "crustacean-free"), ("Dairy Free","dairy-free"), ("Egg Free", "egg-free"), ("Fish Free", "fish-free"), ("Gluten Free", "gluten-free"), ("Immuno Supportive", "immuno-supportive"), ("Keto", "keto-friendly"), ("Low Fat", "low-fat-abs"), ("Low Potassium", "low-potassium"), ("Low Sugar", "low-sugar")]
    
    static let savedLastSearchWord = "lastSearchString"
    
    static let defaultSearchText = "Meat"
    
    static let noSearchResultsFoundErrorString = "No results were found for your search words try different recipe or ingrediants"
}
