//
//  HomeService.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

enum TodoServiceError: Error {
    
    case createTodo(reason: String)
    case selectTodo(id: Int32)
    
}

class TodoService {
    
    private let todoStorage = TodoStorage()
    
    private var todos: [TodoEntity] = []
    private var todosChecked: [TodoEntity] = []
    private var todosUnchecked: [TodoEntity] = []
    
    private var todoSelected: TodoEntity?
    
    func requestTodos() {
        
        self.todos = self.todoStorage.getTodos()
        self.todosChecked = self.todoStorage.getTodos(isChecked: true)
        self.todosUnchecked = self.todoStorage.getTodos(isChecked: false)
        
        NotificationCenter.default.post(name: NSNotification.Name("home.service.todos"), object: todos)
        NotificationCenter.default.post(name: NSNotification.Name("home.service.todosChecked"), object: todosChecked)
        NotificationCenter.default.post(name: NSNotification.Name("home.service.todosUnchecked"), object: todosUnchecked)
        
    }
    
    func createTodo(title: String) {
        
        if let todo = self.todoStorage.createTodo(title: title) {
            
            self.requestTodos()
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoCreated"), object: todo)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoCreateError"), object: TodoServiceError.createTodo(reason: "TodoStorage was error"))
            
        }
        
    }
    
    func selectTodo(byId id: Int32) {
        
        if let todo = self.todoStorage.getTodo(byId: id) {
            
            self.todoSelected = todo
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoSelected"), object: todo)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("home.service.todoSelectError"), object: TodoServiceError.selectTodo(id: id))
            
        }
        
    }
    
}
