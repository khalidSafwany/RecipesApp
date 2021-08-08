//
//  RoundedCornerButton.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/8/21.
//

import Foundation
import UIKit

extension UIButton{
    func setRoundedCorner()  {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
