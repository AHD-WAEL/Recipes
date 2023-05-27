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

    var RecipesList : [Item]!=[]{
        didSet{
            passDataToFavoritesController()
        }
    }
    
    func getAllRecipesFromDB(){
        RecipesList=manager.fetchAll()
    }
    
    func deleteRecipeFromDB(item:Item){
        manager.deleteRow(itemObj: item)
    }
    
    func insertRecipeIntoDB(item:Item){
        manager.insertRow(itemObj: item)
    }
    
}
