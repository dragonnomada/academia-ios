//
//  StoreModel.swift
//  6202_StoreApp_MVVM
//
//  Created by Dragon on 10/01/23.
//

import Foundation
import CoreData
import Combine

class StoreModel {
    
    static let shared = StoreModel()
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StoreModelApp")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("StoreApp container error: \(error)")
            }
        }
        
        return container
    }()
    
    @Published var fruits: [FruitEntity] = []
    
    @Published var selectedIndex: Int?
    @Published var selectedFruit: FruitEntity?
    
    init() {
        self.loadFruits()
    }
    
    deinit {
        self.fruits.removeAll()
    }
    
    func loadFruits() {
        let context = self.container.viewContext
        
        let request = FruitEntity.fetchRequest()
        
        if let fruits = try? context.fetch(request) {
            self.fruits = fruits.reversed()
        }
    }
    
    func selectFruit(index: Int) {
        
        guard index >= 0 && index < self.fruits.count else { return }
        
        self.selectedIndex = index
        self.selectedFruit = self.fruits[index]
        
    }
    
    func addFruit(name: String, amount: Double) {
        let context = self.container.viewContext
        
        let fruit = FruitEntity(context: context)
        
        fruit.name = name
        fruit.amount = amount
        
        do {
            try context.save()
            self.loadFruits()
        } catch {
            context.rollback()
        }
    }
    
    func updateFruit(name: String?, amount: Double?) {
        
        if let selectedFruit = self.selectedFruit {
            if let name = name {
                selectedFruit.name = name
            }
            
            if let amount = amount {
                selectedFruit.amount = amount
            }
            
            let context = container.viewContext
            
            do {
                try context.save()
                self.loadFruits()
            } catch {
                context.rollback()
            }
        }
        
    }
    
    func deleteFruit() {
        
        if let selectedIndex = selectedIndex {
            self.fruits.remove(at: selectedIndex)
            self.selectedIndex = nil
            self.selectedFruit = nil
            self.loadFruits()
        }
        
    }
    
}
