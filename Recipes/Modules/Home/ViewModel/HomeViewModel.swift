//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol{
    var renderRecipies: Observable<Void> { get }
    var recipesCount: Int { get }

    func getHomeCategoriesData(tag: Int, completionHandler:@escaping([Result])->Void)
    func configureCell(cell: ConfigurableCell, index:Int)
}

class HomeViewModel:HomeViewModelProtocol{
   
    var apiClient:ApiClientProtocol
    var recipies: [Result] = .init()
    private(set) var renderRecipies: Observable<Void> = .init()
    var recipesCount: Int {
        recipies.count
    }
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getHomeCategoriesData(tag: Int, completionHandler:@escaping([Result])->Void) {
        guard let recipeCategoryName = RecipeCategory(rawValue: tag)?.name
        else { return }
        apiClient.getData(urlDetails: prepareUrl(category: recipeCategoryName)){ [weak self] (response:Response?) in
            self?.recipies = response?.results ?? []
            self?.renderRecipies.value = ()
        }
    }
    
    func prepareUrl(category: String) -> ApiModel{
        let urlString = "https://tasty.p.rapidapi.com/recipes/list?"
        let category = category
        let parameters: Parameters = [
            "from": "0",
            "size":"20",
            "tags":"\(category)",
        ]
        let url = ApiModel(url: urlString, parameters: parameters, httpMethod:ApiMethod.Get)
        return url
    }
    
    func configureCell(cell:ConfigurableCell,index:Int){
        guard let recipie = recipies[safe: index] else {
            return
        }
        cell.setDataToTableCell(recipie: recipie)
    }
}

// MARK: - Category
private extension HomeViewModel {
    enum RecipeCategory: Int{
        case popular
        case breakfast
        case lunch
        case dinner
        case dessert
        
        var name: String{
            switch self {
            case .popular: return "middle_eastern"
            case .breakfast: return "breakfast"
            case .lunch: return "lunch"
            case .dinner: return "dinner"
            case .dessert: return "desserts"
            }
        }
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
