//
//  TodoInteractor.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation
import Combine

class TodoInteractor {
    
    // Instancia del servicio
    
    private lazy var service: TodoService = {
        
        let service = TodoService()
       
        service.loadTodos()
        
        return service
    }()
    
    // Propagamos subjects
    
    lazy var todosArregloSubject: PassthroughSubject<[TodoEntity], Never> = {
        
        self.service.todosArregloSubject
    }()
    
    lazy var todoSeleccionadoSubject: PassthroughSubject<TodoEntity, Never> = {
        
        self.service.todoSeleccionadoSubject
    }()
    
    // Propagamos operaciones del servicio
    
    func selectTodo(todo: TodoEntity) {
        
        self.service.selectTodo(todo: todo)
    }
}
