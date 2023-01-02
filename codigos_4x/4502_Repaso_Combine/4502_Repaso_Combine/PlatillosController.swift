//
//  PlatillosController.swift
//  4502_Repaso_Combine
//
//  Created by Dragon on 30/12/22.
//

import Foundation
import Combine

class PlatillosController {
    
    // El controlador generalmente es un singleton
    static let shared = PlatillosController()
    
    private var model = PlatillosModel()
    
    // EMISOR DE PLATILLOS
    let platilloSeleccionadoSubject = PassthroughSubject<Platillo, Never>()
    
    func getPlatilloSeleccionado() -> Platillo? {
            return model.platilloSeleccionado
        }
    
    func seleccionarPlatillo(platillo: Platillo) {
        // Lógica de la selección del platillo
        model.platilloSeleccionado = platillo
        print("Se seleccionó el platillo: \(platillo)")
        // EMITE EL PLATILLO A TODOS LOS SUSCRIPTORES
        platilloSeleccionadoSubject.send(platillo)
    }
}
