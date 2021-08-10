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
    
    var suggestionsTableView: UITableView!
    
    var keyboardHeight: CGFloat!
    
    var lastViewedRow = 0
    var selectedRow = -1
    
    private (set) var recipesViewModel: RecipesViewModel?
    var searchRecommendationObject = RecommendationStack()
    var searchRecommendationsViewModel: SearchRecommendationsViewModel?
    var isFilterSelected = false
    
    var recipesList = [recipeObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        recipesSearchBar.delegate = self
        setRecipesViewModel()
        setRecommendationViewModel()
        
        retrieveSession()
        
        self.title = "Recipes"
        self.showSpinner()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        // 1
        print("Keyboard show notification")
        
        // 2
        if let userInfo = notification.userInfo,
            // 3
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            print(keyboardRectangle.height)
            keyboardHeight = keyboardRectangle.height
            showSuggestionsTableView()
        }
    }
    
    
    private func setRecommendationViewModel(){
        searchRecommendationsViewModel = SearchRecommendationsViewModel()
        searchRecommendationsViewModel?.bindRecomendationsToMainView = {
            self.onSuccessRecommendationsFetchUpdateView()
        }
        searchRecommendationsViewModel?.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
        }
        
    }
    private func setRecipesViewModel(){
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
    
    
    private func onSuccessRecommendationsFetchUpdateView(){
        self.searchRecommendationObject = (searchRecommendationsViewModel?.searchRecommendationsObject)!
        print(searchRecommendationObject.getRecommendations())
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
        let _ = recipesViewModel?.fetchallRecipesDataFromAPI(of: lastSearchWord)
        searchRecommendationsViewModel?.fetchSearchRecommendations()
        
        
        
    }
    
    func showSuggestionsTableView() {
            if suggestionsTableView == nil {
                //I get keyboardhight dynamically and 60 is my navigationBar height.
                
                let availHeight = (RecommendationStack.recomendations.count + 2) * 30
                suggestionsTableView = UITableView(frame: CGRect(x: 0, y: 82, width: Int(UIScreen.main.bounds.size.width), height: availHeight), style: .grouped)
                suggestionsTableView.tag = 2
                self.suggestionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggesionCell")
                suggestionsTableView?.delegate = self
                suggestionsTableView?.dataSource = self
                suggestionsTableView.layer.zPosition = .greatestFiniteMagnitude
                self.view.insertSubview(suggestionsTableView, belowSubview: recipesSearchBar)
            suggestionsTableView?.isHidden = false
        }
    }
    
    
    func removeSuggestionsTableView() {
        if suggestionsTableView != nil{
            suggestionsTableView?.removeFromSuperview()
            suggestionsTableView = nil
        }
        }


}

