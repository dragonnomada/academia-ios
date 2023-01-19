//
//  HomeViewController.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Enlace al CollectionView del HomeView.
    
    @IBOutlet weak var homeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registramos la celda y la vista reusable al CollectionView.
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionReusableView")
    }
}
