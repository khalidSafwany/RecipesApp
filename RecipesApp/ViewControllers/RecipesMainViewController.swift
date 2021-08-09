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
    
    var lastViewedRow = 0
    var selectedRow = -1
    
    private (set) var recipesViewModel: RecipesViewModel?
    var isFilterSelected = false
    
    var recipesList = [recipeObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        recipesSearchBar.delegate = self
        setViewModel()
        
        retrieveSession()
        
        self.title = "Recipes"
        self.showSpinner()
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setViewModel(){
        recipesViewModel = RecipesViewModel()
        
        recipesViewModel?.bindRecipesViewModelToView = {
                    
            self.onSuccessFetchUpdateView()
        }
        
        recipesViewModel?.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
        }
        recipesViewModel?.bindNextPageOfRecipesFromViewModelToView = {
            self.onSuccessBindingNewPageUpdateView()
        }
    }
    
    
    // MARK: ViewModel Binders
    
    private func onSuccessFetchUpdateView(){
        recipesList = (recipesViewModel?.currentViewedRecipesList)!
        self.recipesTableView.reloadData()
        let ip = NSIndexPath(row: 0, section: 0)
        self.recipesTableView.scrollToRow(at: ip as IndexPath, at: .bottom, animated: true)
        self.stopSpinner()

        
    }
    
    private func onSuccessBindingNewPageUpdateView(){
        recipesList = (recipesViewModel?.currentViewedRecipesList)!
        self.recipesTableView.reloadData()
        let rowForScroll = lastViewedRow
        let ip = NSIndexPath(row: rowForScroll, section: 0)
        self.recipesTableView.scrollToRow(at: ip as IndexPath, at: .bottom, animated: true)
        
        
    }
    
    
    private func onFailUpdateView(){
        let alert = UIAlertController(title: "Sorry", message: recipesViewModel!.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: extension functions
    
    func fetchNextPageOfRecipes(){
        recipesViewModel?.fetchNextPageOfRecipes()
    }
    
    
    //MARK: segue functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails"{
            if selectedRow != -1 {
                let detailsVC = segue.destination as! RecipeDetailsViewController
                detailsVC.selectedRecipe = recipesList[selectedRow].recipe!
            }
        }
    }
    
    
    private func getlastSavedSearchString()-> String{
        let userDefaults = UserDefaults.standard

        
        return userDefaults.string(forKey: ConstantData.savedLastSearchWord) ?? ConstantData.defaultSearchText
    }
    
    private func retrieveSession(){
        let lastSearchWord = getlastSavedSearchString()
        self.recipesSearchBar.placeholder = lastSearchWord
        recipesViewModel?.fetchallRecipesDataFromAPI(of: lastSearchWord)
        
    }
    


}

