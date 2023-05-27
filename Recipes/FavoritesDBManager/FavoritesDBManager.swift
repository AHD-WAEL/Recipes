//
//  File.swift
//  Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation
import CoreData
import UIKit

protocol FavoritesDBService {
    func insertRow(recipeItem: RecipeItem)
    func deleteRow(recipeItem: RecipeItem)
    func deleteAll()
    func fetchAll() -> [RecipeItem]
    func fetchRow(recipeItem: RecipeItem)->[NSManagedObject]
    func isExist(recipeItem:RecipeItem)->Bool
}

class FavoritesDBManager : FavoritesDBService {
    static let instance = FavoritesDBManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    func insertRow(recipeItem: RecipeItem) {
        
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedContext)
        let favoriteTable = NSManagedObject(entity: entity!, insertInto: managedContext)
        favoriteTable.setValue(recipeItem.recipeId, forKey: Constants.recipeIdKey)
        favoriteTable.setValue(recipeItem.recipeServingsNum, forKey: Constants.recipeServingsNumKey)
        favoriteTable.setValue(recipeItem.recipeName, forKey: Constants.recipeNameKey)
        favoriteTable.setValue(recipeItem.recipeImage, forKey: Constants.recipeImageKey)
        favoriteTable.setValue(recipeItem.recipeType, forKey: Constants.recipeTypeKey)
        favoriteTable.setValue(recipeItem.recipeBy, forKey: Constants.recipeByKey)
        
        do {
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteRow(recipeItem: RecipeItem) {
        let row = fetchRow(recipeItem:recipeItem)
        managedContext.delete(row[0])
        
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        let allRecipes = fetchAll()
        for recipe in allRecipes {
            
            let recipeObj=fetchRow(recipeItem:recipe)
            managedContext.delete(recipeObj[0])
            
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll() -> [RecipeItem] {
        var result = [RecipeItem]()
        var favoriteTable: [NSManagedObject]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        
        do{
            favoriteTable = (try managedContext.fetch(fetchRequest))
            for recipeObj in favoriteTable{
                result.append(RecipeItem(recipeId: recipeObj.value(forKey: Constants.recipeIdKey) as! Int, recipeServingsNum: recipeObj.value(forKey: Constants.recipeServingsNumKey) as! String , recipeName: recipeObj.value(forKey: Constants.recipeNameKey) as! String, recipeImage: recipeObj.value(forKey: Constants.recipeImageKey) as! String, recipeType: recipeObj.value(forKey: Constants.recipeTypeKey) as! String, recipeBy: recipeObj.value(forKey: Constants.recipeByKey) as! String))
            }
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return result
    }
    
    func fetchRow(recipeItem:RecipeItem)->[NSManagedObject] {
        
        var favoriteTable: [NSManagedObject]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        let myPredicate = NSPredicate(format: "recipeId == %i", recipeItem.recipeId)
        fetchRequest.predicate=myPredicate
        
        do {
            favoriteTable = (try managedContext.fetch(fetchRequest))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return favoriteTable
    }
    
    func isExist(recipeItem: RecipeItem) -> Bool {
        let allRecipes = fetchAll()
        
        for recipe in allRecipes {
            if(recipe.recipeId == recipeItem.recipeId) {
                return true
            }
        }
        return false
    }
}

extension FavoritesDBManager{
    class Constants{
        static let entityName = "FavoritesTable"
        static let recipeIdKey = "recipeId"
        static let recipeServingsNumKey = "recipeServingsNum"
        static let recipeNameKey = "recipeName"
        static let recipeImageKey = "recipeImage"
        static let recipeTypeKey = "recipeType"
        static let recipeByKey = "recipeBy"
    }
}
