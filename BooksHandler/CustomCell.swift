//
//  CustomCell.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import UIKit

class CustomCell: UITableViewCell {

   
    @IBOutlet weak var imageViewImage: CustomImageView!
    
    @IBOutlet weak var labelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageViewImage.layer.cornerRadius = 0.5
        self.imageView?.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
