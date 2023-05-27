//
//  ViewController.swift
//  Recipes
//
//  Created by Mac on 25/05/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var recipesCategoryStackView: UIStackView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var popylarBtn: UIButton!
    @IBOutlet weak var breakfastBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var dinnerBtn: UIButton!
    @IBOutlet weak var dessertBtn: UIButton!
    
    var recipeCategoryBtnArray: [UIButton] = []
    var homeViewModel:HomeViewModelProtocol! = HomeViewModel(apiClient: ApiClient())
    var categoryRecipieArr:[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecipeCategoryBtns()
        setNibFileForRecipeCell()
        configureBinding()
        loadHomeDataFromApi()
    }
    
    func configureBinding() {
        homeViewModel.recipies.bind { [weak self] _ in
            guard let self = self else { return }
            self.table.reloadData()
        }
    }
    
    func loadHomeDataFromApi(){
            homeViewModel.getHomeCategoriesData(category: "breakfast") {[weak self] recipiesArr in
                self!.categoryRecipieArr = recipiesArr
                self!.table.reloadData()
            }
        }
    
    func setupRecipeCategoryBtns(){
        popylarBtn.layer.cornerRadius = 25
        breakfastBtn.layer.cornerRadius = 25
        lunchBtn.layer.cornerRadius = 25
        dinnerBtn.layer.cornerRadius = 25
        dessertBtn.layer.cornerRadius = 25
        
        popylarBtn.titleLabel?.isHidden = true
        breakfastBtn.titleLabel?.isHidden = true
        lunchBtn.titleLabel?.isHidden = true
        dinnerBtn.titleLabel?.isHidden = true
        dessertBtn.titleLabel?.isHidden = true
        
        recipeCategoryBtnArray.append(popylarBtn)
        recipeCategoryBtnArray.append(breakfastBtn)
        recipeCategoryBtnArray.append(lunchBtn)
        recipeCategoryBtnArray.append(dinnerBtn)
        recipeCategoryBtnArray.append(dessertBtn)
    }

    func setNibFileForRecipeCell(){
        let nibFile = UINib(nibName: "RecipeCell", bundle: nil)
        table.register(nibFile, forCellReuseIdentifier: "cell")
    }
  
    @IBAction func onRecipeCategoryBtnTapped(_ sender: UIButton) {
        
        for categoryClickedBtn in recipeCategoryBtnArray{
            
            categoryClickedBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
            
            if categoryClickedBtn == sender{
                categoryClickedBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
            }
        }
    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryRecipieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
//        cell.recipeNamelabel.text = categoryRecipieArr[indexPath.row].name
//        cell.recipeCheifLabel.text = "By: \(categoryRecipieArr[indexPath.row].credits[0].name)"
//        cell.recipeServeingsNoLabel.text = categoryRecipieArr[indexPath.row].yields
//        cell.recipeImg.kf.setImage(with: URL(string: categoryRecipieArr[indexPath.row].thumbnail_url),placeholder: UIImage(named: "Rectangle 20"))
        homeViewModel.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

