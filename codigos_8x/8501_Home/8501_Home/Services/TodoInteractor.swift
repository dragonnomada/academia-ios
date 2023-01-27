//
//  HomeInteractor.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

class TodoInteractor {
    
    lazy var service: TodoService = {
        
        let service = TodoService()
        
        return service
        
    }()
    
    func requestTodos() {
        
        self.service.requestTodos()
        
    }
    
    func createTodo(title: String) {
        
        guard !title.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoCreateError"), object: TodoServiceError.createTodo(reason: "Title is empty"))
            
            return
            
        }
        
        self.service.createTodo(title: title)
        
    }
    
    func selectTodo(byId id: Int32) {
        
        guard id >= 0 else {
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoSelectError"), object: TodoServiceError.selectTodo(id: id))
            
            return
            
        }
        
        self.service.selectTodo(byId: id)
        
    }
    
}
