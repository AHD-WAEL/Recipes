//
//  FavoritesViewModel.swift
//  Recipes
//
//  Created by Mac on 27/05/2023.
//

import Foundation

class FavoritesViewModel{
    var manager : FavoritesDBService
    var passDataToFavoritesController:(()->Void) = {}
    var RecipesList : [RecipeItem]!=[]{
        didSet{
            passDataToFavoritesController()
        }
    }
    init(manager: FavoritesDBService) {
        self.manager = manager
    }
    func getAllRecipesFromDB(){
        RecipesList=manager.fetchAll()
    }
    func deleteRecipeFromDB(item:RecipeItem){
        manager.deleteRow(itemObj: item)
    }
}
