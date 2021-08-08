//
//  TableViewCell.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import UIKit

class RecipeTableCell: UITableViewCell {

    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeHealthLabels: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
