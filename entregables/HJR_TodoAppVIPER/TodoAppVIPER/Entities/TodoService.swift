//
//  TodoService.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import Foundation
import CoreData
import Combine


class TodoService {
    
    // State
    private var todos: [TodoEntity] = []
    private var todoSeleccionado: TodoEntity?
    private var todoSeleccionadoIndex: Int?
    
    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("No se pudo cargar el contenedor TodoApp")
            }
        }
        
        return container
    }()
    
    // Notifiers
    
    var todosSubject = PassthroughSubject<[TodoEntity], Never>()
    var todoAddSubject = PassthroughSubject<TodoEntity, Never>()
    var todoSeleccinadoSubject = PassthroughSubject<(index: Int, todo: TodoEntity), Never>()
    var todoEditadoSubject = PassthroughSubject<TodoEntity, Never>()
    var todoEliminadoSubject = PassthroughSubject<(index: Int, todo: TodoEntity), Never>()
    
    // Funtionalities
    
    func loadTodos() {
        let context = self.container.viewContext
        
        let request = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(request) {
            self.todos = todos
        }
    }
    
    // Transactions
    
    // recarga el arreglo de todos una ves que se modifique
    func recargarTodos() {
        
        self.todosSubject.send(self.todos)
        
    }
    
    func addTodo(title: String) {
        print("Agregando Todo")
        
        let context = self.container.viewContext
        
        let todo = TodoEntity(context: context)
        
        todo.title = title
        todo.checked = false
        
        do {
            try context.save()
            self.loadTodos()
            print("Todo agregado: \(todo)")
        } catch {
            context.rollback()
            print("Error al agregar el Todo: \(todo)")
        }
        
        self.todoAddSubject.send(todo)
        self.recargarTodos()
    }
}
