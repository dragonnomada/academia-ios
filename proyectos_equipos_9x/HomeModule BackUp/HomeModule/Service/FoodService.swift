//
//  FoodService.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

enum FoodServiceError: Error {
    
    case createFood(reason: String)
    case selectFood(reason: String)
    
}

class FoodService {
    
    private let foodStorage = FoodStorage()
    
    private var foods: [FoodEntity] = []
    private var filteredFoods: [FoodEntity] = []
    
    private var selectedFood: FoodEntity?
    
    func requestFoods() {
        
        self.foods = self.foodStorage.getFoods()
        
        NotificationCenter.default.post(name: NSNotification.Name("food.service.foods"), object: foods)
    }
    
    func searchFoods(_ keyword: String) {
        
        self.filteredFoods = self.foodStorage.getFoods(keyword)
        NotificationCenter.default.post(name: NSNotification.Name("food.service.filteredFoods"), object: filteredFoods)
    }
    
    func createFood(name: String, calories: Double, fats: Double, sugars: Double, fiber: Double, carbs: Double, proteins: Double, unit: String, factor: Double, image: Data?) {
        
        if let food = self.foodStorage.createFood(name: name, calories: calories, fats: fats, sugars: sugars, fiber: fiber, carbs: carbs, proteins: proteins, unit: unit, factor: factor, image: image) {
            
            self.requestFoods()
            
            NotificationCenter.default.post(name: NSNotification.Name("food.service.foodCreated"), object: food)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("food.service.foodCreateError"), object: FoodServiceError.createFood(reason: "FoodStorage returned nil when creating a food"))
            
        }
        
    }
    
    func selectFood(byIndex index: Int, inFoods foods: [FoodEntity]) {
        
        guard index >= 0 && index < foods.count else {
            
            NotificationCenter.default.post(name: NSNotification.Name("food.service.selectedFoodError"), object: FoodServiceError.selectFood(reason: "index out of bounds for FoodService.foods"))
            return
        }
            
            self.selectedFood = foods[index]
            
        NotificationCenter.default.post(name: NSNotification.Name("food.service.selectedFood"), object: self.selectedFood)
        
    }
    
}
