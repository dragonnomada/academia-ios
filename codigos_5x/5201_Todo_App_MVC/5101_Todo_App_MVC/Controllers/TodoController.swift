//
//  TodoController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import Foundation

class TodoController {
    
    static let shared = TodoController()
    
    let model = TodoModel()
    
    var homeDelegate: TodoHomeDelegate?
    var addDelegate: TodoAddDelegate?
    var detailDelegate: TodoDetailDelegate?
    var editDelegate: TodoEditDelegate?
    
    // var addDelegate: [TodoAddDelegate] = []
    
    func selectTodo(index: Int, todo: TodoEntity) {
        
        model.selectTodo(index: index, todo: todo)
        detailDelegate?.todo(todoUpdated: todo)
    }
    
    func getTodos() {
        
        self.model.loadTodos()
        
        homeDelegate?.todo(todosUpdated: self.model.todos)
        
    }
    
    func getSelectedTodo() {
        
        if let todo = self.model.todoSelected {
            
            detailDelegate?.todo(todoUpdated: todo)
            editDelegate?.todo(todoUpdated: todo)
            
        }
        
    }
    
    func addTodo(title: String) {
        
        if let todo = self.model.addTodo(title: title) {
            
            homeDelegate?.todo(todosUpdated: self.model.todos)
            
            addDelegate?.todo(todoCreated: todo)
            
        } else {
            
            addDelegate?.todo(todoCreateError: "No se pudo agregar el nuevo Todo")
            
        }
        
    }
    
    func updateTodoTitle(title: String) {
        
        if let index = self.model.todoSelectedIndex {
            
            if let todo = self.model.updateTodoTitle(index: index, title: title) {
                
                homeDelegate?.todo(todosUpdated: self.model.todos)
                detailDelegate?.todo(todoUpdated: todo)
                editDelegate?.todo(todoEdited: todo)
                
            } else {
                
                editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
                
            }
            
        } else {
            
            editDelegate?.todo(todoEditError: "No hay Todo seleccionado")
            
        }
        
    }
    
    func updateTodoCheck(checked: Bool) {
        
        if let index = self.model.todoSelectedIndex {
            
            if let todo = self.model.updateTodoCheck(index: index, checked: checked) {
                
                homeDelegate?.todo(todosUpdated: self.model.todos)
                detailDelegate?.todo(todoUpdated: todo)
                editDelegate?.todo(todoEdited: todo)
                
            } else {
                
                editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
                
            }
            
        } else {
            
            editDelegate?.todo(todoEditError: "No hay Todo seleccionado")
            
        }
        
    }
    
    func deleteTodo() {
        
        if let index = self.model.todoSelectedIndex {
            
            if let todo = self.model.deleteTodo(index: index) {
                
                homeDelegate?.todo(todosUpdated: self.model.todos)
                editDelegate?.todo(todoDeleted: todo)
                
            } else {
                
                editDelegate?.todo(todoEditError: "No se pudo elimar el Todo")
                
            }
            
        } else {
            
            editDelegate?.todo(todoEditError: "No hay Todo seleccionado")
            
        }
        
    }
    
}
