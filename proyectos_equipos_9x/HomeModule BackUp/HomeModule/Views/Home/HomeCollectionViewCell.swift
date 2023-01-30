//
//  HomeCollectionViewCell.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(title: String, details: String, image: UIImage) {
        
        self.titleLabel.text = title
        self.detailsLabel.text = details
        self.imageCell.image = image
    }

}
