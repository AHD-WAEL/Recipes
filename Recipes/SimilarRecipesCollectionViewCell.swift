//
//  SimilarRecipesCollectionViewCell.swift
//  Recipes
//
//  Created by Mac on 27/05/2023.
//

import UIKit

class SimilarRecipesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var similarRecipesFavBtn: UIButton!
    @IBOutlet weak var similarRecipesChiefLabel: UILabel!
    @IBOutlet weak var similarRecipesNameLabel: UILabel!
    @IBOutlet weak var similarServiceNoLabel: UILabel!
    @IBOutlet weak var similarRecipesNoImg: UIImageView!
    @IBOutlet weak var similarRecipesImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
       
   override var frame: CGRect {
       get {
           return super.frame
       }
       set (newFrame) {
           var frame = newFrame
           frame.origin.x += 8
           frame.size.width -= 2 * 8
           frame.origin.y += 8
           frame.size.height -= 2 * 8
           super.frame = frame
       }
   }
    
    func setupUI(){
        similarRecipesFavBtn.layer.cornerRadius = 12
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
    }
}
