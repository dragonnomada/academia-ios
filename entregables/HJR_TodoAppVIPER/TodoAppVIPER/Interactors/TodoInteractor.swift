//
//  TodoInteractor.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import Foundation
import Combine

class TodoInteractor {
    
    // Service
    // Instanciar el servicio
    
    private lazy var service: TodoService = {
        let service = TodoService()
        
        // Inicializa el servicio
        
        return service
    }()
    
    // Notificators
    
    lazy var frutasListSubject: PassthroughSubject<[TodoEntity], Never> = {
        return self.service.todosSubject
    }()
    
    lazy var todoAddSubject: PassthroughSubject<TodoEntity, Never> = {
        return self.service.todoAddSubject
    }()
    
    lazy var todoSeleccinadoSubject: PassthroughSubject<(index: Int, todo: TodoEntity), Never> = {
        return self.service.todoSeleccinadoSubject
    }()
    
    // Operations
    
    func recargarTodoSeleccionado() {
        
        self.service.recargarTodos()
        
    }
    
    func recargarTodos() {
        
        self.service.recargarTodos()
        
    }
    
    func agregarTodo(title: String) {
        
        self.service.addTodo(title: title)
        
    }
    
}

