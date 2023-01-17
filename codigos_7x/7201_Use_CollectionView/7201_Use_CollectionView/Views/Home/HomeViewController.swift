//
//  HomeViewController.swift
//  7201_Use_CollectionView
//
//  Created by Dragon on 17/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var frutasCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frutasCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FrutasCollectionViewCell")
        
        frutasCollectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FrutasHeaderCollectionReusableView")
        
        frutasCollectionView.dataSource = self
        
        frutasCollectionView.delegate = self
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrutasCollectionViewCell", for: indexPath)
        
        // TODO: Configurar la celda
        if let cell = cell as? HomeCollectionViewCell {
            
            cell.setup(label: "Fruta \(indexPath.section) \(indexPath.row)")
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FrutasHeaderCollectionReusableView", for: indexPath)
        
        // TODO: Configurar el header
        if let reusableView = reusableView as? HomeCollectionReusableView {
            
            reusableView.setup(title: "Sección \(indexPath.section)", subtitle: "\(Date.now)")
            
        }
        
        return reusableView
        
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 68)
        }
        
        return CGSize(width: collectionView.bounds.width, height: 94)
        
    }
    
}
