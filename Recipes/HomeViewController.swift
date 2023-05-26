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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecipeCategoryBtns()
        setNibFileForRecipeCell()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

