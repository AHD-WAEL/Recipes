//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol{
    var recipies: Observable<[Result]> { get }
    var recipesCount:Int { get }

    func getHomeCategoriesData(category:String,completionHandler:@escaping([Result])->Void)
    func configureCell(cell:ConfigurableCell,index:Int)
}

class HomeViewModel:HomeViewModelProtocol{
   
    var apiClient:ApiClientProtocol
    private(set) var recipies: Observable<[Result]> = .init() {
        didSet {
            guard let value = recipies.value else { return }
            recipesCount = value.count
            print(recipesCount)
        }
    }
    var recipesCount = 0
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getHomeCategoriesData(category: String, completionHandler: @escaping([Result]) -> Void) {
        apiClient.getData(urlDetails: prepareUrl(category: category)){ [weak self] (response:Response?) in
            self!.recipies.value = response?.results ?? []
            completionHandler(response?.results ?? .init())
//            self!.recipesCount = response?.results.count ?? 0
        }
    }
    
    func prepareUrl(category:String) -> ApiModel{
        let urlString = "https://tasty.p.rapidapi.com/recipes/list?"
        let category = "breakfast"
        let parameters: Parameters = [
            "from": "0",
            "size":"20",
            "tags":"\(category)",
        ]
        let url = ApiModel(url: urlString, parameters: parameters, httpMethod:ApiMethod.Get)
        return url
    }
    
    func configureCell(cell:ConfigurableCell,index:Int){
        guard let recipie = recipies.value?[index] else { return }
        cell.setDataToTableCell(recipie: recipie)
    }
}

class Observable<T> {
    typealias Observer = ((T) -> Void)

    var value: T? {
        didSet {
            executeObservers()
        }
    }
    var observers: [Observer] = []
    
    init(value: T? = nil) {
        self.value = value
    }
    
    func bind(observer: @escaping Observer) {
        self.observers.append(observer)
    }
    
    private func executeObservers() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let value = value else { return }

            self.observers.forEach { observer in
                observer(value)
            }
        }
    }
}
