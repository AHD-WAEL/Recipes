//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation



protocol HomeViewModelProtocol{
    var recipies: Observable<[Result]> { get }
    
    func getHomeCategoriesData(category:String,completionHandler:@escaping([Result])->Void)
    func configureCell(cell:ConfigurableCell,index:Int)
}

class HomeViewModel:HomeViewModelProtocol{
    var apiClient:ApiClientProtocol
    private(set) var recipies: Observable<[Result]> = .init() {
        didSet {
            guard let value = recipies.value else { return }
            recipesCount = value.count
        }
    }
    var recipesCount = 0
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getHomeCategoriesData(category: String, completionHandler: @escaping([Result]) -> Void) {
        apiClient.getRecipesForACategory(category: category) { [weak self]response in
            self!.recipies.value = response?.results ?? []
            completionHandler(response?.results ?? .init())
//            self!.recipesCount = response?.results.count ?? 0
        }
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
