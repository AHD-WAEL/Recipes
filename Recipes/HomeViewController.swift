//
//  ViewController.swift
//  Recipes
//
//  Created by Mac on 25/05/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var recipesCategoryStackView: UIStackView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var popylarBtn: UIButton!
    @IBOutlet weak var breakfastBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var dinnerBtn: UIButton!
    @IBOutlet weak var dessertBtn: UIButton!
    
    var recipeCategoryBtnArray: [UIButton] = []
    var tapedRecipeCategoryBtn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecipeCategoryBtns()
        setNibFileForRecipeCell()
    }
    
    func setupRecipeCategoryBtns(){
        //popylarBtn.sendActions(for: .touchUpInside)
        
        popylarBtn.backgroundColor = UIColor(red: Constants.tapedRedColorRecipeButton, green: Constants.tapedGreenColorRecipeButton, blue: Constants.tapedBlueColorRecipeButton, alpha: Constants.alphaEqualsOne)
        
        popylarBtn.layer.cornerRadius = Constants.recipeCategoryButtonCornerRadius
        breakfastBtn.layer.cornerRadius = Constants.recipeCategoryButtonCornerRadius
        lunchBtn.layer.cornerRadius = Constants.recipeCategoryButtonCornerRadius
        dinnerBtn.layer.cornerRadius = Constants.recipeCategoryButtonCornerRadius
        dessertBtn.layer.cornerRadius = Constants.recipeCategoryButtonCornerRadius
        
        recipeCategoryBtnArray.append(popylarBtn)
        recipeCategoryBtnArray.append(breakfastBtn)
        recipeCategoryBtnArray.append(lunchBtn)
        recipeCategoryBtnArray.append(dinnerBtn)
        recipeCategoryBtnArray.append(dessertBtn)
    }

    func setNibFileForRecipeCell(){
        let nibFile = UINib(nibName: Constants.recipeCellNibFileName, bundle: nil)
        table.register(nibFile, forCellReuseIdentifier: Constants.cellIdentifier)
    }
  
    @IBAction func onRecipeCategoryBtnTapped(_ sender: UIButton) {
        
        for categoryClickedBtn in recipeCategoryBtnArray{
            
            categoryClickedBtn.backgroundColor = UIColor(red: Constants.resetRedColorRecipeButton, green: Constants.resetGreenColorRecipeButton, blue: Constants.resetBlueColorRecipeButton, alpha: Constants.alphaEqualsOne)
            
            if categoryClickedBtn == sender{
                categoryClickedBtn.backgroundColor = UIColor(red: Constants.tapedRedColorRecipeButton, green: Constants.tapedGreenColorRecipeButton, blue: Constants.tapedBlueColorRecipeButton, alpha: Constants.alphaEqualsOne)
                tapedRecipeCategoryBtn = categoryClickedBtn.tag
                print("++++++++++++++++++ \(tapedRecipeCategoryBtn)")
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! RecipeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController{
    class Constants{
        static let recipeCategoryButtonCornerRadius = CGFloat(25)
        static let recipeCellNibFileName = "RecipeCell"
        static let cellIdentifier = "cell"
        static let resetRedColorRecipeButton = 0.890
        static let resetGreenColorRecipeButton = 0.897
        static let resetBlueColorRecipeButton = 0.916
        static let alphaEqualsOne = CGFloat(1)
        static let tapedRedColorRecipeButton = 0.851
        static let tapedGreenColorRecipeButton = 0.588
        static let tapedBlueColorRecipeButton = 0.317
    }
}
