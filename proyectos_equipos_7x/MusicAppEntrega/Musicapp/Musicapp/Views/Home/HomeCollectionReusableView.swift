//
//  HomeCollectionReusableView.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    
    // Enlace a los Labels del CollectionReusableView.
    @IBOutlet weak var generoLabel: UILabel!
    
    @IBOutlet weak var numeroCancionesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // Función que configura las etiquetas de la colecciópn, en Género musical y número de canciones disponibles.
    func setup(gender: SongGender, songsCount count: Int) {
        
        self.generoLabel.text = "\(gender.rawValue) 🎸"
        self.numeroCancionesLabel.text = "\(count) canciones"
    }
    
}
