//
//  HomeCollectionViewCell.swift
//  7201_Use_CollectionView
//
//  Created by Dragon on 17/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(label: String) {
        self.myLabel.text = label
    }

}
