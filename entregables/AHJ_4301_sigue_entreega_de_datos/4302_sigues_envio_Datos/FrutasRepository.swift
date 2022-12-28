//
//  FrutasRepository.swift
//  4302_sigues_envio_Datos
//
//  Created by MacBook  on 28/12/22.
//

import Foundation


struct Fruta {
    
    let nombre: String
    var peso: Double
    
}


class FrutasRepository{
    // singletton
    static let shared = FrutasRepository()
    
    var frutas: [Fruta] = [
        Fruta(nombre: "manzana", peso: 3.2),
        Fruta(nombre: "mango", peso: 1.4),
        Fruta(nombre: "pera", peso: 6.2),
        Fruta(nombre: "piña", peso: 2.3),
        Fruta(nombre: "kiwi", peso: 2.6),
        Fruta(nombre: "fresa", peso: 4.1)
    ]
    
    func getFrutasCount() -> Int {
        return frutas.count
    }
    
    
    func getFrutas(index: Int) -> Fruta? {
        if index >= 0 && index < frutas.count{
            return frutas[index]
        }else{
            return nil
        }
    }
}

