//
//  File.swift
//  Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation
import CoreData
import UIKit

protocol FavoritesDBService{
    func insertRow(itemObj:RecipeItem)
    func deleteRow(itemObj:RecipeItem)
    func deleteAll()
    func fetchAll()->[RecipeItem]
    func fetchRow(item:RecipeItem)->[NSManagedObject]
    func isExist(item:RecipeItem)->Bool
}

class FavoritesDBManager : FavoritesDBService{
    static let instance = FavoritesDBManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext :NSManagedObjectContext!
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func insertRow(itemObj:RecipeItem){
        let entity = NSEntityDescription.entity(forEntityName: "FavoritesTable", in: managedContext)
        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
        movie.setValue(itemObj.recipeId, forKey: "recipeId")
        movie.setValue(itemObj.recipeServingsNum, forKey: "recipeServingsNum")
        movie.setValue(itemObj.recipeName, forKey: "recipeName")
        movie.setValue(itemObj.recipeImage, forKey: "recipeImage")
        movie.setValue(itemObj.recipeType, forKey: "recipeType")
        movie.setValue(itemObj.recipeBy, forKey: "recipeBy")
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteRow(itemObj:RecipeItem){
        let row = fetchRow(item:itemObj)
        managedContext.delete(row[0])
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteAll(){
        let rows = fetchAll()
        for item in rows{
            let row=fetchRow(item:item)
            managedContext.delete(row[0])
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll()->[RecipeItem]{
        var result=[RecipeItem]()
        var arr:[NSManagedObject]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritesTable")
        do{
            arr=(try managedContext.fetch(fetchRequest))
            for item in arr{
                result.append(RecipeItem(recipeId: item.value(forKey: "recipeId") as! Int, recipeServingsNum: item.value(forKey: "recipeServingsNum") as! String , recipeName: item.value(forKey: "recipeName") as! String, recipeImage: item.value(forKey: "recipeImage") as! String, recipeType: item.value(forKey: "recipeType") as! String, recipeBy: item.value(forKey: "recipeBy") as! String))
            }
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return result
    }
    
    func fetchRow(item:RecipeItem)->[NSManagedObject]{
        
        var arr:[NSManagedObject]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritesTable")
        let myPredicate = NSPredicate(format: "recipeId == %i", item.recipeId)
        fetchRequest.predicate=myPredicate
        do{
            arr=(try managedContext.fetch(fetchRequest))
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return arr
    }
    
    func isExist(item:RecipeItem)->Bool{
        
        let list = fetchAll()
        for recipe in list{
            if(recipe.recipeId==recipe.recipeId){
                return true
            }
        }
        return false
    }
}
