//
//  BitacoraHomeView.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import Foundation

// MARK: Protocols
// protocolos requeridos para la vista BitacoraHome

protocol BitacoraHomeView: NSObject {
    
    func bitacora(bitacoras: [BitacoraEntity])
    
    func bitacora(bitacoraSelected: BitacoraEntity)
}
