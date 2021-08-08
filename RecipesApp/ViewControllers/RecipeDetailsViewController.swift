//
//  RecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/7/21.
//

import UIKit
import SDWebImage
import SafariServices

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var ingrediantsTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var viewWebsiteButton: UIButton!
    
    var selectedRecipe = Recipe()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingrediantsTableView.delegate = self
        ingrediantsTableView.dataSource = self
        setViewByRecipeDetails()
        
    
        // Do any additional setup after loading the view.
        
    }
    
    private func setViewByRecipeDetails(){
        viewWebsiteButton.setRoundedCorner()
        self.title = selectedRecipe.label
        if let recipeimageURL = selectedRecipe.image{
        recipeImageView.sd_setImage(with: URL(string: recipeimageURL), completed: nil)
        }
        
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        if let recipeURL = selectedRecipe.uri{
        let someText:String = recipeURL
        let objectsToShare:URL = URL(string: recipeURL)!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func recipeWebsiteButtonAction(_ sender: Any) {
        if let recipeURL = selectedRecipe.url{
            let safariVC = SFSafariViewController(url:URL(string:recipeURL)!)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
}
