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
    
    func requestFoodSelected() {
        
        self.service.requestFoodSelected()
    }
    
    func selectFood(byId id: Int32) {
    
        self.service.selectFood(byId: id)
        
    }
    
    func createFood(id: Int32, name: String, calories: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, sugar: Double, units: Double, image: Data?) {
        
        self.service.createFood(id: id, name: name, calories: calories, carbs: carbs, fat: fat, fiber: fiber, protein: protein, sugar: sugar, units: units, image: image)
        
    }
    
    func updateFood(name: String, calories: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, sugar: Double, units: Double, image: Data?) {
        
        self.service.updateFood(name: name, calories: calories, carbs: carbs, fat: fat, fiber: fiber, protein: protein, sugar: sugar, units: units, image: image)
        
    }
    
}
