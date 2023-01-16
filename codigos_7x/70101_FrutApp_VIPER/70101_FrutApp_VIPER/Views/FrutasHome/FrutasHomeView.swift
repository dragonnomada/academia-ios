//
//  FrutasHomeView.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation

protocol FrutasHomeView: NSObject {
    
    // Delegates (Consumers)
    
    func frutas(frutasCargadas frutas: [FrutaEntity])
    
    func frutas(frutaSeleccionada fruta: FrutaEntity, index: Int)
    
}
