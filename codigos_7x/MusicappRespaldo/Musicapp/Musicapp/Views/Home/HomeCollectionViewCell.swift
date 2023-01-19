//
//  HomeCollectionViewCell.swift
//  Musicapp
//
//  Created and Mantained by Brian Jiménez Moedano on 18/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // Enlace al imageView de la CollectionViewCell.
    @IBOutlet weak var songImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // Función que configura la imagen de las canciones disponibles en la colección.
    func setupSongImage(_ image: UIImage) {
        
        self.songImage.image = image
    }

}
