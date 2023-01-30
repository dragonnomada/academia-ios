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
    private var foodUpdateed: FoodEntity?
    
    func requestFood() {
        
        self.totalFood = self.foodStorage.getFood()
        
        NotificationCenter.default.post(name: NSNotification.Name("requestFoodService"), object: totalFood)
        
    }
    
    func requestFoodSelected() {
        
        guard let foodSelected = self.foodSelected else {
            NotificationCenter.default.post(name: NSNotification.Name("foodServiceFoodSelectedError"), object: nil)
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("foodServiceFoodSelected"), object: foodSelected)
        
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

    func createFood(id: Int32, name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        if let food = self.foodStorage.createFood(id: id, name: name, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units) {
            
            self.foodSelected = food
            
            NotificationCenter.default.post(name: NSNotification.Name("foodCreatedService"), object: food)
            
        }
        
    }
    
    
    func updateFood(name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        guard let foodSelected = self.foodSelected else {
            // TODO: Informar error no seleccionado
            NotificationCenter.default.post(name: NSNotification.Name("foodUpdatedServiceError"), object: FoodServiceError.updateFood)
            return
        }
        
        if let foodUpdateed = self.foodStorage.updateFood(id: foodSelected.id, name: name, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units) {
            
            self.requestFood()
            
            self.foodSelected = foodUpdateed
            
            // Envia la notificacion de que un alimento ha sido modificado(actualizado)
            NotificationCenter.default.post(name: NSNotification.Name("foodUpdatedService"), object: foodUpdateed)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("foodUpdatedServiceError"), object: FoodServiceError.updateFood)
            
        }
        
    }
    
}
