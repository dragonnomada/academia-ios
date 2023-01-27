//
//  HomeStorage.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation
import CoreData

class TodoStorage {
    
    private lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TodoModel")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("[TodoStorage/Container] HomeModel loadPersistentStores")
                
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
    
    func createTodo(title: String) -> TodoEntity? {
        
        let todo = TodoEntity(context: self.context)
        
        todo.id = Int32.random(in: 1...Int32.max)
        todo.title = title
        todo.checked = Bool.random()
        todo.createAt = Date.now
        
        return self.save() ? todo : nil
        
    }
    
    func getTodos() -> [TodoEntity] {
        
        if let todos = try? self.context.fetch(TodoEntity.fetchRequest()) {
            
            return todos
            
        } else {
            
            return []
            
        }
        
    }
    
    func getTodos(isChecked: Bool) -> [TodoEntity] {
        
        if let todos = try? self.context.fetch(TodoEntity.fetchRequest()).filter({ $0.checked == isChecked }) {
            
            return todos
            
        } else {
            
            return []
            
        }
        
    }
    
    func getTodo(byId id: Int32) -> TodoEntity? {
        
        if let todo = try? self.context.fetch(TodoEntity.fetchRequest()).filter({ $0.id == id }).first {
            
            return todo
            
        } else {
            
            return nil
            
        }
        
    }
    
}
