//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation



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
    
    func getHomeCategoriesData(tag: Int, completionHandler: @escaping([Result]) -> Void) {
        guard let recipeCategoryName = RecipeCategory(rawValue: tag)?.name
        else { return }
        
        print("viewModel------------- \(recipeCategoryName)")
        
        apiClient.getRecipesForACategory(category: recipeCategoryName) { [weak self] response in
            self?.recipies = response?.results ?? []
            self?.renderRecipies.value = ()
            
//            completionHandler(response?.results ?? .init())
        }
    }
    
//    func getHomeCategoryBy(tag: Int) {
//        guard let recipeCategoryName = RecipeCategory(rawValue: tag)?.name
//        else { return }
//
//    }
    
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

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
