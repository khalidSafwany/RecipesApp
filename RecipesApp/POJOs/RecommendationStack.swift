//
//  Stack.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/10/21.
//

import Foundation
class RecommendationStack {
  static var recomendations = [String]()
    
   func push(_ element: String) {
    if RecommendationStack.recomendations.count == 10{
        
        for i in RecommendationStack.recomendations.count - 1 ... 0 {
            if i > 0{
                RecommendationStack.recomendations[i - 1] = RecommendationStack.recomendations[i]
            }
        }
    }
    RecommendationStack.recomendations.append(element)
    }
    
   func pop() -> String? {
     
      return RecommendationStack.recomendations.popLast()
    }
    
    func getRecommendations()-> [String]{
        return RecommendationStack.recomendations
    }
}
