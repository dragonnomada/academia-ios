//
//  TodoCoreDataService.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation
import CoreData

class TodoCoreDataService {
    
    lazy var container: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Todo_VIPER_BJM")
        
        container.loadPersistentStores { _, error in
            
            if let error = error {
                
                fatalError("Error, no se pudo cargar el contenedor (CoreData): ... \(error)")
            }
        }
        
        return container
    }()
    
    func loadTodosCoreData() -> [TodoEntity]? {
        
        let context = self.container.viewContext
        
        let todoRequest = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(todoRequest) {
            
            return todos
        } else {
            
            return nil
        }
    }
    
    func addTodoCoreData(todo: TodoEntity) {
        
        let context = self.container.viewContext
        
        let todoToAdd = TodoEntity(context: context)
        
        todoToAdd.title = todo.title
        todoToAdd.checked = todo.checked
        
        do {
            
            try context.save()
        } catch {
            
            context.rollback()
        }
    }
}
