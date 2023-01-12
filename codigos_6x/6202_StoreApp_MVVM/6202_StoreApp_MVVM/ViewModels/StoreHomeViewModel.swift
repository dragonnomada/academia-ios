//
//  StoreHomeViewModel.swift
//  6202_StoreApp_MVVM
//
//  Created by Dragon on 10/01/23.
//

import Foundation
import Combine

protocol StoreHomeView: AnyObject {
    
    /// Todas las frutas actualizadas
    func fruits(fruitsUptated fruits: [FruitEntity])
    
    /// La fruta seleccionada
    func fruits(fruitSelected fruit: FruitEntity)
    
}

class StoreHomeViewModel {
    
    // ESCUCHA
    //var modelSubscriber: AnyCancellable?
    
    weak var fruitsSubscriber: AnyCancellable?
    weak var fruitSelectedSubscriber: AnyCancellable?
    
    // COMUNICA
    weak var view: StoreHomeView?
    
    weak var currentSelectedFruit: FruitEntity?
    
    init() {
        
        self.fruitsSubscriber = StoreModel.shared.$fruits.sink {
            fruits in
            self.view?.fruits(fruitsUptated: fruits)
        }
        
        self.fruitSelectedSubscriber = StoreModel.shared.$selectedFruit.sink {
            selectedFruit in
            if let selectedFruit = selectedFruit {
                self.view?.fruits(fruitSelected: selectedFruit)
            }
        }
        
    }
    
    deinit {
        print("ELIMINANDO StoreHomeViewModel")
        self.fruitsSubscriber?.cancel()
        self.fruitsSubscriber = nil
        self.fruitSelectedSubscriber?.cancel()
        self.fruitSelectedSubscriber = nil
        self.view = nil
    }
    
    func getFruits() {
        self.view?.fruits(fruitsUptated: StoreModel.shared.fruits)
    }
    
    // INTERACTUA
    func selectFruit(index: Int) {
        StoreModel.shared.selectFruit(index: index)
    }
    
}
