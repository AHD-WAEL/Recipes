//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit
import Kingfisher
class FavoritesViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak private var noFavoriteRecipes: UIView!
    @IBOutlet weak private var table: UITableView!
    //MARK: - Properties
    var favoritesViewModel = FavoritesViewModel(manager: FavoritesDBManager.instance)
    override func viewDidLoad() {
        super.viewDidLoad()
        setNibFileForRecipeCell()
        favoritesViewModel.passDataToFavoritesController={[weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        favoritesViewModel.getAllRecipesFromDB()
        checkIfThereAreFavoriteRecipes(list: favoritesViewModel.RecipesList)
    }
    func setNibFileForRecipeCell(){
        let nibFile = UINib(nibName: "RecipeCell", bundle: nil)
        self.table.register(nibFile, forCellReuseIdentifier: "cell")
    }
    func checkIfThereAreFavoriteRecipes(list:[RecipeItem]){
        self.table.backgroundView = list.isEmpty ? noFavoriteRecipes: .none
    }
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.RecipesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
            cell.recipeImg.kf.setImage(with: URL(string:favoritesViewModel.RecipesList[indexPath.row].recipeImage))
            cell.recipeCheifLabel.text=favoritesViewModel.RecipesList[indexPath.row].recipeBy
            cell.recipeCategoryLabel.text=favoritesViewModel.RecipesList[indexPath.row].recipeType
            cell.recipeNamelabel.text=favoritesViewModel.RecipesList[indexPath.row].recipeName
            cell.recipeServeingsNoLabel.text=favoritesViewModel.RecipesList[indexPath.row].recipeServingsNum
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let alert = UIAlertController(title: "Warning!!", message: "Are You sure you want to delete this recipe?", preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){_ in
                self.favoritesViewModel.deleteRecipeFromDB(recipeItem: self.favoritesViewModel.RecipesList[indexPath.row])
                self.favoritesViewModel.RecipesList.remove(at: indexPath.row)
                self.table.reloadData()
                self.checkIfThereAreFavoriteRecipes(list: self.favoritesViewModel.RecipesList)
            }
            let action2 = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true)
           
        }
    }
}
