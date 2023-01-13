//
//  StoreAddViewModel.swift
//  6202_StoreApp_MVVM
//
//  Created by Dragon on 10/01/23.
//

import Foundation
import Combine

// TODO: Protocolo StoreAddView

protocol StoreAddView: AnyObject {
    
    // TODO: Motificadores
    func fruits(fruitAdded fruit: FruitEntity)
    
}

// TODO: Clase StoreAddViewModel

class StoreAddViewModel {
    
    // TODO: Suscriptor de las publicadores del modelo
    var fruitsSubscriber: AnyCancellable?
    
    // TODO: View
    weak var view: StoreAddView?
    
    // TODO: Inicializador
    init() {
        // TODO: Suscribir los cambios del modelo
        self.fruitsSubscriber = StoreModel.shared.$fruits.dropFirst().sink {
            fruits in
            
            if let fruit = fruits.first {
                print("Fruta agregada: \(fruit.name ?? "SIN NOMBRE") [\(fruit.amount) kg]")
                self.view?.fruits(fruitAdded: fruit)
            }
            
        }
    }
    
    // TODO: Deinicializador
    deinit {
        print("ELIMINANDO StoreAddViewModel")
    }
    
    func unsubscribe() {
        self.fruitsSubscriber?.cancel()
        self.fruitsSubscriber = nil
        self.view = nil
    }
    
    // TODO: Funcionalidades
    func addFruit(name: String, amount: Double) {
        
        StoreModel.shared.addFruit(name: name, amount: amount)
        
    }
    
}
