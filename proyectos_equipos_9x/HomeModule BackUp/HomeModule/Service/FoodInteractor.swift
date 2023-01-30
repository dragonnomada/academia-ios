//
//  FoodInteractor.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

class FoodInteractor {
    
    lazy var service: FoodService = {
        
        let service = FoodService()
        
        return service
        
    }()
    
    func requestFoods() {
        
        self.service.requestFoods()
        
    }
    
    func searchFoods(_ keyword: String) {
        
        self.service.searchFoods(keyword)
    }
    
    func createFood(name: String, calories: Double, fats: Double, sugars: Double, fiber: Double, carbs: Double, proteins: Double, unit: String, factor: Double, image: Data?) {
        
        guard !name.isEmpty, !calories.isLess(than: 0.0), !fats.isLess(than: 0.0), !sugars.isLess(than: 0.0), !fiber.isLess(than: 0.0), !carbs.isLess(than: 0.0), !proteins.isLess(than: 0.0), !unit.isEmpty, !factor.isLess(than: 0.0) else {
            
            NotificationCenter.default.post(name: NSNotification.Name("food.service.foodCreateError"), object: FoodServiceError.createFood(reason: "Invalid arguments"))
            
            return
            
        }
        
        self.service.createFood(name: name, calories: calories, fats: fats, sugars: sugars, fiber: fiber, carbs: carbs, proteins: proteins, unit: unit, factor: factor, image: image)
        
    }
    
    func selectFood(byIndex: Int, inFoods: [FoodEntity]) {
        
        self.service.selectFood(byIndex: byIndex, inFoods: inFoods)
    }
    
}
