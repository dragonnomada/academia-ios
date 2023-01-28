//
//  FoodInteractor.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation

class FoodInteractor {
    
    lazy var service: FoodService = {
        
        let service = FoodService()
        
        return service
        
    }()
    
    func requestFood() {
        
        self.service.requestFood()
    }
    
    func selectFood(byId id: Int32) {
    
        self.service.selectFood(byId: id)
        
    }
    
    func updateFood(name: String, id: Int32, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        self.service.updateFood(name: name, id: id, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units)
        
    }
    
        
        
    
}
