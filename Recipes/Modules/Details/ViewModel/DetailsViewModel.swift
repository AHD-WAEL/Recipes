//
//  DetailsViewModel.swift
//  Recipes
//
//  Created by Ahmed on 27/05/2023.
//

import Foundation
import Alamofire

protocol DetailsViewModelProtocol{
    
    var renderDetails:Observable<Void> { get }
    var instructionsCount:Int { get }
    var ingredientsCount:Int { get }
    var similarRecipiesCount:Int { get }
    
    func getDetailsData(using id:String)
}

class DetailsViewModel:DetailsViewModelProtocol{
    
    let group = DispatchGroup()
    
    var apiClient:ApiClientProtocol
    var renderDetails: Observable<Void> = .init()
    
    var instructionsArray: [Instruction] = []
    var instructionsCount: Int{
        instructionsArray.count
    }
    var ingridientsArray: [Section] = []
    var ingredientsCount: Int{
        ingridientsArray.count
    }
    var similarRecipiesArr:[Result] = []
    var similarRecipiesCount: Int{
        similarRecipiesArr.count
    }
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getDetailsData(using id: String){
        getRecipeDetails(using: id)
        getSimilarRecipes(using: id)
        group.notify(queue: .main){ [weak self] in
            self?.renderDetails.value = ()
        }
    }
    
    private func getRecipeDetails(using id: String) {
        group.enter()
        apiClient.getData(urlDetails: prepareUrlForRecipeDetails(id: id)){ [weak self] (response:Result?) in
            self?.ingridientsArray = response?.sections ?? []
            self?.instructionsArray = response?.instructions ?? []
            self?.group.leave()
        }
    }
    
    private func getSimilarRecipes(using id: String) {
        group.enter()
        apiClient.getData(urlDetails: prepareUrlForSimilarRecipes(id: id)){ [weak self] (response:[Result]?) in
            self?.similarRecipiesArr = response ?? []
            self?.group.leave()
        }
    }
    
    func prepareUrlForRecipeDetails(id: String) -> ApiModel{
        let urlString = URLConstents.recipeDetailsURl
        let parameters: Parameters = [
            "id": "\(id)"
        ]
        let url = ApiModel(url: urlString, parameters: parameters, httpMethod:ApiMethod.Get)
        return url
    }
    
    func prepareUrlForSimilarRecipes(id: String) -> ApiModel{
        let urlString = URLConstents.similarRecipesURl
        let parameters: Parameters = [
            "recipe_id": "\(id)"
        ]
        let url = ApiModel(url: urlString, parameters: parameters, httpMethod:ApiMethod.Get)
        return url
    }
}

class URLConstents{
    static let similarRecipesURl = "https://tasty.p.rapidapi.com/recipes/list-similarities?"
    static let recipeDetailsURl = "https://tasty.p.rapidapi.com/recipes/get-more-info?"
}
