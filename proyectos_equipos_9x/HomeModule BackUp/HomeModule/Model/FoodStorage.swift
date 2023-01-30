//
//  FoodStorage.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//
import Foundation
import CoreData

class FoodStorage {
    
    private lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "HomeModel")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("Error al crear contenedor [HomeModel/FoodStorage]")
                
            }
            
        }
        
        return container
        
    }()
    
    private var context: NSManagedObjectContext { self.container.viewContext }
    
    private func save() -> Bool {
        
        do {
            
            try self.context.save()
            return true
            
        } catch {
            
            self.context.rollback()
            return false
            
        }
        
    }
    
    // CRUD Operations
    
    func createFood(name: String, calories: Double, fats: Double, sugars: Double, fiber: Double, carbs: Double, proteins: Double, unit: String, factor: Double, image: Data?) -> FoodEntity? {
        
        let food = FoodEntity(context: self.context)
        
        food.name = name
        food.calories = calories
        food.fats = fats
        food.sugars = sugars
        food.fiber = fiber
        food.carbs = carbs
        food.proteins = proteins
        food.unit = unit
        food.factor = factor
        food.image = image
        
        return self.save() ? food : nil
        
    }
    
    func getFoods() -> [FoodEntity] {
        
        if let foods = try? self.context.fetch(FoodEntity.fetchRequest()) {
            
            return foods
            
        } else {
            
            return []
            
        }
        
    }
    
    
    func getFoods(_ keyword: String) -> [FoodEntity] {
        
        if let foods = try? self.context.fetch(FoodEntity.fetchRequest()) {
            
            guard !keyword.isEmpty else { return foods }
            
            let filteredFoods = foods.filter({ $0.name!.lowercased().contains(keyword.lowercased()) })

            return filteredFoods

        } else {

            return []

        }

    }
    
    
}

