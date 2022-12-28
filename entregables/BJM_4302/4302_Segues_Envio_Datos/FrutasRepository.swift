//
//  FrutasRepository.swift
//  4302_Segues_Envio_Datos
//
//  Created by User on 28/12/22.
//

import Foundation

struct Fruta {
    
    let nombre: String
    var peso: Double
    
}

class FrutasRepository {
    
    static let shared = FrutasRepository()
    
    var frutas: [Fruta] = [
        Fruta(nombre: "Manzana", peso: 3.2),
        Fruta(nombre: "Mango", peso: 1.4),
        Fruta(nombre: "Pera", peso: 6.2),
        Fruta(nombre: "Piña", peso: 2.3),
        Fruta(nombre: "Kiwi", peso: 2.6),
        Fruta(nombre: "Fresa", peso: 4.1)
    ]
    
    func getFrutasCount() -> Int {
        return frutas.count
    }
    
    func getFruta(index: Int) -> Fruta? {
        if index >= 0 && index < frutas.count {
            return frutas[index]
        } else {
            return nil
        }
    }
    
}
