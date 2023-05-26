//
//  ViewController.swift
//  Recipes
//
//  Created by Mac on 25/05/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var popylarBtn: UIButton!
    @IBOutlet weak var breakfastBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var dinnerBtn: UIButton!
    @IBOutlet weak var dessertBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNibFile()
        
        popylarBtn.layer.cornerRadius = 25
        breakfastBtn.layer.cornerRadius = 25
        lunchBtn.layer.cornerRadius = 25
        dinnerBtn.layer.cornerRadius = 25
        dessertBtn.layer.cornerRadius = 25
    }

    func setNibFile(){
        let nibFile = UINib(nibName: "RecipeCell", bundle: nil)
        table.register(nibFile, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func popularBtnAction(_ sender: Any) {
        popylarBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
        breakfastBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        lunchBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dinnerBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dessertBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
    }
    
    @IBAction func breakfastBtnAction(_ sender: Any) {
        breakfastBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
        popylarBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        lunchBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dinnerBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dessertBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
    }
    
    @IBAction func lunchBtnAction(_ sender: Any) {
        lunchBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
        breakfastBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        popylarBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dinnerBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dessertBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
    }
    
    @IBAction func dinnerBtnAction(_ sender: Any) {
        dinnerBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
        breakfastBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        lunchBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        popylarBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dessertBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
    }
    
    @IBAction func dessertBtnAction(_ sender: Any) {
        dessertBtn.backgroundColor = UIColor(red: 0.851, green: 0.588, blue: 0.317, alpha: 1)
        breakfastBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        lunchBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        dinnerBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
        popylarBtn.backgroundColor = UIColor(red: 0.890, green: 0.897, blue: 0.916, alpha: 1)
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

