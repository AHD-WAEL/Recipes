//
//  SimilarRecipiesView.swift
//  Recipes
//
//  Created by Mac on 27/05/2023.
//

import UIKit

class SimilarRecipiesView: UIView {

    @IBOutlet weak var similarRecipesCollectionView: UICollectionView!
    
    func setNibFileForRecipeCell(){
        let nibFile = UINib(nibName: String(describing: SimilarRecipesCollectionViewCell.self), bundle: nil)
        similarRecipesCollectionView.register(nibFile, forCellWithReuseIdentifier: "SimilarRecipesCollectionViewCell")
    }

}

extension SimilarRecipiesView: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarRecipesCollectionViewCell", for: indexPath) as! SimilarRecipesCollectionViewCell
        
        return cell
    }
}
