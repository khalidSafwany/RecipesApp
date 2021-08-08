//
//  FilterCellCollectionViewCell.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/8/21.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var filterWordLabel: UILabel!
    
    func setRoundCorner(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
