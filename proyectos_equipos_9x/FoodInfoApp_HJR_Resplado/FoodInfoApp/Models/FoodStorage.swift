//
//  FoodStorage.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
// FoodEntity

import Foundation
import CoreData

class FoodStorage {
    
    // Generando un ocntenedor persistente
    private lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FoodEntity")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("[TodoStorage/Container] HomeModel loadPersistentStores")
                
            }
            
        }
        
        return container
        
    }()
    
    // Contexto
    private var context: NSManagedObjectContext { self.container.viewContext }
    
    // Funcion que nos permite guardar una actualizacion a nuestro contenedor
    private func save() -> Bool {
        
        do {
            
            try self.context.save()
            return true
            
        } catch {
            
            self.context.rollback()
            return false
            
        }
        
    }
    
    
    // Obtiene todos los alimentos desde el contenedor
    func getFood() -> [FoodEntity] {
        
        if let food = try? self.context.fetch(FoodEntity.fetchRequest()) {
            
            return food
            
        } else {
            
            return []
            
        }
        
    }
    
    // Selecciona un alimento deseado
    func getFoodSelect(byId id: Int32) -> FoodEntity? {
        
        if let food = try? self.context.fetch(FoodEntity.fetchRequest()).filter({ $0.id == id }).first {
            
            return food
            
        } else {
            
            return nil
            
        }
        
    }
    
    // Edita el almiento previamente seleccionado
    func updateFood(name: String, id: Int32, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) -> FoodEntity? {
        
        let food = FoodEntity(context: self.context)
        
        food.name = "Anonimo"
        food.id = Int32.random(in: 1...10)
        food.calorias = Double.random(in: 1...30)
        food.carbs = Double.random(in: 1...30)
        food.fat = Double.random(in: 1...30)
        food.fiber = Double.random(in: 1...30)
        food.protein = Double.random(in: 1...30)
        food.suggar = Double.random(in: 1...30)
        food.units = Double.random(in: 1...30)
        
        return self.save() ? food : nil
        
    }
    
}
