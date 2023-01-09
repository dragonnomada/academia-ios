//
//  TodoModel.swift
//  6103_Todo_MVVM
//
//  Created by Dragon on 09/01/23.
//

import Foundation
import CoreData
import Combine

class TodoModel {
    
    static let shared = TodoModel()
    
    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("No se pudo cargar el contenedor TodoApp")
            }
        }
        
        return container
    }()
    
    /// Son los `todos` para los *vista-modelos*
    @Published var todos: [TodoEntity] = []
    
    @Published var todoAdded: (sessionId: Int, todo: TodoEntity?) = (0, nil)
    
    func loadTodos() {
        let context = self.container.viewContext
        
        let request = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(request) {
            self.todos = todos
        }
    }
    
    func addTodo(sessionId: Int, title: String) {
        print("Agregando Todo para la sesión: \(sessionId)")
        
        let context = self.container.viewContext
        
        let todo = TodoEntity(context: context)
        
        todo.title = title
        
        do {
            try context.save()
            self.loadTodos()
            print("Todo agregado con la sesión: \(sessionId)")
            self.todoAdded = (sessionId, todo)
        } catch {
            context.rollback()
            print("Error al agregar el Todo con la sesión \(sessionId)")
            self.todoAdded = (sessionId, nil)
        }
    }
    
}
