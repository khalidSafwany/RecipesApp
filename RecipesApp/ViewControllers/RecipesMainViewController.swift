//
//  ViewController.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/5/21.
//

import UIKit

class RecipesMainViewController: UIViewController {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var recipesSearchBar: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    
    private var recipesViewModel: RecipesViewModel?
    
    var recipesList = [recipeObject](){
        didSet{
            self.recipesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        setViewModel()
        recipesViewModel?.fetchallRecipesDataFromAPI()
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setViewModel(){
        recipesViewModel = RecipesViewModel()
        
        recipesViewModel?.bindRecipesViewModelToView = {
                    
            self.onSuccessUpdateView()
        }
        
        recipesViewModel?.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
        }
    }
    
    
    private func onSuccessUpdateView(){
        recipesList = (recipesViewModel?.currentViewedRecipesList)!
        
    }
    
    
    private func onFailUpdateView(){
        let alert = UIAlertController(title: "Error", message: recipesViewModel!.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


}

