//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation

enum TodoServiceError: Error {
    
    case notTodoSelected
    
}

@available(macOS 12, *)
class TodoService {
    
    var todos: [TodoEntity] = []
    var todoSelected: TodoEntity?
    
    func generateSampleTodos() {
        
        for i in 1...10 {
            self.createTodo(title: "Fake Todo \(i)")
        }
        
        print(self.todos)
        
    }
    
    func createTodo(title: String) {
        
        let todo = TodoEntity(id: Int.random(in: 1...Int.max), title: title, checked: Bool.random(), createdAt: Date.now)
        
        self.todos.append(todo)
        
        self.todoSelected = todo
        
        NotificationCenter.default.post(name: NSNotification.Name("TodoService.createTodo.success"), object: todo)
        
    }
    
    func postTodos() {
        
        NotificationCenter.default.post(name: NSNotification.Name("TodoService.postTodos.success"), object: self.todos)
        
    }
    
    func postSelectedTodo() {
        
        if let todo = self.todoSelected {
            
            NotificationCenter.default.post(name: NSNotification.Name("TodoService.postTodos.success"), object: todo)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("TodoService.postTodos.error"), object: TodoServiceError.notTodoSelected)
            
        }
        
    }
    
}
