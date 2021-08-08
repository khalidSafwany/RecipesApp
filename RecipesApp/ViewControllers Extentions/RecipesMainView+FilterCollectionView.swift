//
//  RecipesMainView+FilterCollectionView.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/8/21.
//

import Foundation
import UIKit

extension RecipesMainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ConstantData.filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let (key, _) = ConstantData.filterOptions[indexPath.row]
        let filterCell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        filterCell.setRoundCorner()
        filterCell.filterWordLabel.text = key
        
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isFilterSelected = true
        if indexPath.row == 0{
            recipesViewModel?.setViewedRecipesToAllRecipes()
        }else{
           
            recipesViewModel?.fetchFilterRecipesFromAPI(filterIndex: indexPath.row)
            self.showSpinner()
        }
       
    }
    
    
    
    
}
