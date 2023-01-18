//
//  FrutasEditView.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation

protocol FrutasEditView: NSObject {
    
    func frutas(frutaSeleccionada fruta: FrutaEntity, index: Int)
    
    func frutas(frutaEditada fruta: FrutaEntity)
    
    func frutas(frutaEliminada fruta: FrutaEntity, index: Int)
    
}
