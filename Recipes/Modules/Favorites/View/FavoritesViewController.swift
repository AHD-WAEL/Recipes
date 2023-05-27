//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit
import Kingfisher
class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var noFavoriteRecipes: UIView!
    @IBOutlet weak var table: UITableView!
    var favoritesViewModel = FavoritesViewModel(manager: FavoritesDBManager.instance)
    override func viewDidLoad() {
        super.viewDidLoad()
        setNibFileForRecipeCell()
        let item1 = RecipeItem(recipeId: 1, recipeServingsNum: "1", recipeName: "Pizza", recipeImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkldJ0LiL7mxhUKNC6nlcroRv50EEWPJ-X3A&usqp=CAU", recipeType: "Lunch", recipeBy: "Ahmed")
        let item2 = RecipeItem(recipeId: 2, recipeServingsNum: "2", recipeName: "chicken", recipeImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkldJ0LiL7mxhUKNC6nlcroRv50EEWPJ-X3A&usqp=CAU", recipeType: "Lunch", recipeBy: "Safiya")
        let item3 = RecipeItem(recipeId: 3, recipeServingsNum: "3", recipeName: "cheese", recipeImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkldJ0LiL7mxhUKNC6nlcroRv50EEWPJ-X3A&usqp=CAU", recipeType: "Dinner", recipeBy: "Ahd")
        favoritesViewModel.passDataToFavoritesController={[weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        favoritesViewModel.insertRecipeIntoDB(item: item1)
        favoritesViewModel.insertRecipeIntoDB(item: item2)
        favoritesViewModel.insertRecipeIntoDB(item: item3)
        favoritesViewModel.getAllRecipesFromDB()
        checkIfThereAreFavoriteRecipes(list: favoritesViewModel.RecipesList)
    }
    func setNibFileForRecipeCell(){
        let nibFile = UINib(nibName: "RecipeCell", bundle: nil)
        self.table.register(nibFile, forCellReuseIdentifier: "cell")
    }
    func checkIfThereAreFavoriteRecipes(list:[RecipeItem]){
        if(list.count != 0){
            self.table.backgroundView = nil
        }
        else{
            self.table.backgroundView = noFavoriteRecipes
        }
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
            print(favoritesViewModel.RecipesList[indexPath.row].recipeImage)
            print(favoritesViewModel.RecipesList[indexPath.row].recipeBy)
            print(favoritesViewModel.RecipesList[indexPath.row].recipeType)
            print(favoritesViewModel.RecipesList[indexPath.row].recipeName)
            print(favoritesViewModel.RecipesList[indexPath.row].recipeServingsNum)
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
                self.favoritesViewModel.deleteRecipeFromDB(item: self.favoritesViewModel.RecipesList[indexPath.row])
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
