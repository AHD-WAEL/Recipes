//
//  FavoritesViewModel.swift
//  Recipes
//
//  Created by Mac on 27/05/2023.
//

import Foundation

class FavoritesViewModel{
    var manager : FavoritesDBService
    init(manager: FavoritesDBService) {
        self.manager = manager
    }
    
    var passDataToFavoritesController:(()->Void) = {}

    var RecipesList : [RecipeItem]!=[]{
        didSet{
            passDataToFavoritesController()
        }
    }
    
    func getAllRecipesFromDB(){
        RecipesList=manager.fetchAll()
    }
    
    func deleteRecipeFromDB(item:RecipeItem){
        manager.deleteRow(itemObj: item)
    }
    
    func insertRecipeIntoDB(item:RecipeItem){
        manager.insertRow(itemObj: item)
    }
    
}
