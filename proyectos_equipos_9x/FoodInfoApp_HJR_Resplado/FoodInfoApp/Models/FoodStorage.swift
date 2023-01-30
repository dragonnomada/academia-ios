//
//  FoodStorage.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
// FoodEntity

import Foundation
import CoreData

class FoodStorage {
    
    // Generando un contenedor persistente
    private lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FoodModel")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("[FoodStorage/Container] FoodModel loadPersistentStores")
                
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
    
    //Crea un alimento
    func createFood(id: Int32, name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) -> FoodEntity? {
        
        let food = FoodEntity(context: self.context)
        
        food.id = id
        food.name = name
        food.calorias = calorias
        food.carbs = carbs
        food.fat = fat
        food.fiber = fiber
        food.protein = protein
        food.suggar = suggar
        food.units = units
        
        print("Creado food")

        return self.save() ? food : nil
        
    }
    
    // Edita el almiento
    func updateFood(id: Int32, name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) -> FoodEntity? {
        
        guard let food = self.getFoodSelect(byId: id) else {
            return nil
        }
        
        food.name = name
        food.id = Int32.random(in: 1...10)
        food.calorias = calorias
        food.carbs = carbs
        food.fat = fat
        food.fiber = fiber
        food.protein = protein
        food.suggar = suggar
        food.units = units
        
        print("Guardando food")

        return self.save() ? food : nil
        
    }
    
}
