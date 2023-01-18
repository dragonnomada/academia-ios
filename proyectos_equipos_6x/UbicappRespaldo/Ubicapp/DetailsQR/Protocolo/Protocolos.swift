//
//  Protocolos.swift
//  Ubicapp
//
//  Created by MacBook  on 13/01/23.
//

import Foundation


protocol QRView: NSObject {
    func ubicacion(ubicacionSelecionada: UbicacionEntity?)
    func ubicacion(ubicacionActualizada ubicacion: UbicacionEntity?)
}

