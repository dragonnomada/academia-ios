//
//  FrutasEditViewController.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import UIKit

class FrutasEditViewController: UIViewController {

    weak var presenter: FrutasEditPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension FrutasEditViewController: FrutasEditView {
    
    func frutas(frutaSeleccionada fruta: FrutaEntity, index: Int) {
        
        
        
    }
    
    func frutas(frutaEditada fruta: FrutaEntity) {
        
        
        
    }
    
    func frutas(frutaEliminada fruta: FrutaEntity, index: Int) {
        
        
        
    }
    
}
