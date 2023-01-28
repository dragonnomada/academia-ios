//
//  FoodService.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation

enum FoodServiceError: Error {
    
    case selectFood(id: Int32)
    case updateFood
    
}

class FoodService {
    
    private let foodStorage = FoodStorage()
    private var totalFood: [FoodEntity] = []
    private var foodSelected: FoodEntity?
    
    func requestFood() {
        
        self.totalFood = self.foodStorage.getFood()
        
        NotificationCenter.default.post(name: NSNotification.Name("requestFoodService"), object: totalFood)
        
    }
    
    func selectFood(byId id: Int32) {
        
        if let food = self.foodStorage.getFoodSelect(byId: id) {
            
            self.foodSelected = food
            
            // Creamos un notificador llamado "foodServiceFoodSelected" el cual notificara que un alimento ha sido seleccionado y envia cual fue ese alimento seleccionado
            NotificationCenter.default.post(name: NSNotification.Name("foodServiceFoodSelected"), object: food)
            
        } else {
            
            // Creamos un notificador llamado "foodServiceFoodSelected" el cual notificara que hubo un error al seleccionar un alimento
            NotificationCenter.default.post(name: NSNotification.Name("foodServiceFoodSelected.Error"), object: FoodServiceError.selectFood(id: id))
            
        }
        
    }
    
    func updateFood(name: String, id: Int32, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        if let food = self.foodStorage.updateFood(name: name, id: id, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units) {
            
            self.requestFood()
            
            NotificationCenter.default.post(name: NSNotification.Name("foodUpdatedService"), object: food)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("foodUpdatedServiceError"), object: FoodServiceError.updateFood)
            
        }
        
    }
    
}
