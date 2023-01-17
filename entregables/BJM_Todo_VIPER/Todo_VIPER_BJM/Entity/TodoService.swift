//
//  TodoService.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation
import CoreData
import Combine

class TodoService {
    
    // Estado del modelo Todo
    
    private var todos: [TodoEntity] = []
    private var todoSeleccionado: TodoEntity?
    
    // Instancia del CoreData Service
    
    weak var todoCoreDataService: TodoCoreDataService?
    
    // Notificadores del modelo Todo
    
    var todosArregloSubject = PassthroughSubject<[TodoEntity], Never>()
    var todoSeleccionadoSubject = PassthroughSubject<TodoEntity, Never>()
    
    // Loaders
    
    func loadTodos() {
        
        if let todos = self.todoCoreDataService?.loadTodosCoreData() {
            
            self.todos = todos
            if self.todos.isEmpty {
                
                self.loadTodosDefault()
            }
        } else {
            
            print("No se pudo cargar Todos")
        }
    }
    
    func loadTodosDefault() {
        
        let todo1 = TodoEntity()
        todo1.title = "Comprar frutas"
        todo1.checked = false
        
        let todo2 = TodoEntity()
        todo2.title = "Terminar proyecto VIPER"
        todo2.checked = false
        
        let todo3 = TodoEntity()
        todo3.title = "Barrer y trapear sala"
        todo3.checked = true
        
        self.todoCoreDataService?.addTodoCoreData(todo: todo1)
        self.todoCoreDataService?.addTodoCoreData(todo: todo2)
        self.todoCoreDataService?.addTodoCoreData(todo: todo3)
        
        if let todos = self.todoCoreDataService?.loadTodosCoreData() {
            
            self.todos = todos
        } else {
            
            print("No se pudo cargar Todos por default")
        }
    }
    
    // Transacciones
    
    func selectTodo(todo: TodoEntity) {
        
        self.todoSeleccionado = todo
    }
}
