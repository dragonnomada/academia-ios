//
//  TodoModel.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import Foundation
import CoreData

class TodoModel {
    
    // 1.- Se crea el contenedor.
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor \(error)")
            }
        }
        
        return container
    }()
    
    // Variable global donde se almacenaran todos los "Todos creados"
    var todos: [TodoEntity] = []
    
    // Variable global que retendra el "Todo" seleccionado
    var todoSelected: TodoEntity?
    // Variable global que retendra el index(posicion) del "Todo" seleccionado
    var todoSelectedIndex: Int?
    
    
    func selectTodo(index: Int, todo: TodoEntity) {
        self.todoSelected = todo
        self.todoSelectedIndex = index
    }
    
    // Funcon para cargar los "Todos" existentes en nuestro contenedor
    func loadTodos() {
        
        let context = self.persistentContainer.viewContext
        
        let requestTodos = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(requestTodos) {
            
            self.todos = todos
            
        }
        
    }
    
    func getTodo(index: Int) -> TodoEntity? {
        
        guard index >= 0 && index < self.todos.count else { return nil }
        
        return self.todos[index]
        
    }
    
    func addTodo(title: String) -> TodoEntity? {
        
        print("Agregando Todo \(title)")
        
        let context = self.persistentContainer.viewContext
        
        let todo = TodoEntity(context: context)
        
        todo.id = Int32.random(in: 1...1_000_000)
        todo.title = title
        todo.checked = false
        todo.createAt = Date.now
        
        do {
            try context.save()
            self.loadTodos()
            return todo
        } catch {
            context.rollback()
            return nil
        }
        
    }
    
    func updateTodoTitle(index: Int, title: String) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.title = title
            todo.updateAt = Date.now
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
    func updateTodoCheck(index: Int, checked: Bool) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.checked = checked
            todo.updateAt = Date.now
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
    func deleteTodo(index: Int) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            let context = self.persistentContainer.viewContext
            
            context.delete(todo)
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
}
