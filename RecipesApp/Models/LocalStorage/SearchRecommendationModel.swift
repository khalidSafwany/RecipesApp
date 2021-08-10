//
//  SearchRecommendationModel.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/10/21.
//

import Foundation
import CoreData
import UIKit

struct SearchRecommendationModel{
    private (set) var searchRecommendationObject: RecommendationStack?
    
    mutating func fetchRecommendationsFromCoreData(completion : @escaping (RecommendationStack?, Error?)->()){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest(entityName: "SearchRecommendation") as NSFetchRequest<NSManagedObject>
        do{
        let fetchData = try manageContext.fetch(request)
            convertfetchData(fetchedData: fetchData)
            completion(searchRecommendationObject, nil)
            
        }catch let error{
            print(error)
            completion(nil, error)
        }
    }
    
    private mutating func convertfetchData(fetchedData:[NSManagedObject]){
        searchRecommendationObject = RecommendationStack()
        for word in fetchedData as! [SearchRecommendation]{
            
            searchRecommendationObject?.push(word.recommendation ?? "")
        }
       
    }
    
    static func saveRecommendationsToCoreData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        for element in RecommendationStack.recomendations{
            let newRecomendation = SearchRecommendation(context:manageContext)
            newRecomendation.recommendation = element
        }
        
        do{
        try manageContext.save()
            print("saved to coreData")
        }catch let error{
            print(error)
            }
        
        
        
    }
}
