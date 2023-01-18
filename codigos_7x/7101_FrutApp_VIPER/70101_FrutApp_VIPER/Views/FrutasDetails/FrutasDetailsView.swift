//
//  FrutasDetailsView.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation

protocol FrutasDetailsView: NSObject {
    
    func frutas(frutaSeleccionada fruta: FrutaEntity)
    
}
