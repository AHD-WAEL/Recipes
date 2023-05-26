//
//  TableViewCell.swift
//  Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeServeingsNoLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var recipeCheifLabel: UILabel!
    @IBOutlet weak var recipeNamelabel: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favBtn.titleLabel?.isHidden = true
        favBtn.layer.cornerRadius = 12
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
