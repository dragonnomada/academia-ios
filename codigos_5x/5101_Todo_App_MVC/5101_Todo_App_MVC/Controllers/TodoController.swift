//
//  TodoController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import Foundation

/// Establece el protocolo para alguien capaz de recibir una lista
/// de `TodoEntity`
protocol TodoGetable {
    
    // ([TodoEntity]) -> Void
    func onTodos(todos: [TodoEntity])
    
}

protocol TodoCreatable {
    
    // (TodoEntity, [TodoEntity]) -> Void
    func onTodoCreated(todo: TodoEntity, todos: [TodoEntity])
    
}

protocol TodoUpdatable {
    
    // (TodoEntity, [TodoEntity]) -> Void
    func onTodoUpdated(todo: TodoEntity, todos: [TodoEntity])
    
}

protocol TodoDeletable {
    
    // (TodoEntity, [TodoEntity]) -> Void
    func onTodoDeleted(todo: TodoEntity, todos: [TodoEntity])
    
}

/// El controlador es el responsable de utilizar un modelo (o varios)
/// de manera adecuada, es decir, hace las operaciones lógicas
/// y mantiene la integridad de datos, por ejemplo, hace validaciones
/// para que el modelo se utilice de forma adecuada.
///
/// Podemos pensar en el controlador como la carátula o el administrador
/// del modelo, al cuál lo oculta de la vista, para que se consuma
/// de forma responsable. También agrega protocolos para notificarle
/// a la vista que todo salió bien o mal, dependiendo.
///
/// **Nota:** el controlador se dice activo por tener una instancia
///         global y mecanismos para notificar hacía las vistas lo
///         que ocurre dentro de las funciones.
class TodoController {
    
    /// Creamos una instancia global (`Singleton`)
    static let shared = TodoController()
    
    /// El controlador depende de un modelo, por lo que
    /// retiene una instancia del modelo que será utilizado
    let model = TodoModel()
    
    /// Carga y devuelve los `todos` del modelo
    ///
    /// **Nota:** La salida de esta función no es un valor devuelto, sino
    /// que a través de un protocolo arrojamos la salida
    func getTodos(onTodos getable: TodoGetable?) {
        
        model.loadTodos()
        getable?.onTodos(todos: model.todos)
        
    }
    
    func addTodo(title: String, onTodoCreated creatable: TodoCreatable?) {
        
        if let todo = model.addTodo(title: title) {
            
            creatable?.onTodoCreated(todo: todo, todos: model.todos)
            
        }
        
    }
    
    func updateTodoTitle(index: Int, title: String, onTodoUpdated updatable: TodoUpdatable?) {
        
        if let todo = model.updateTodoTitle(index: index, title: title) {
            
            updatable?.onTodoUpdated(todo: todo, todos: model.todos)
            
        }
        
    }
    
    func updateTodoCheck(index: Int, checked: Bool, onTodoUpdated updatable: TodoUpdatable?) {
        
        if let todo = model.updateTodoCheck(index: index, checked: checked){
            
            updatable?.onTodoUpdated(todo: todo, todos: model.todos)
            
        }
        
    }
    
    func deleteTodo(index: Int, onTodoDeleted deletable: TodoDeletable?) {
        
        if let todo = model.deleteTodo(index: index) {
            
            deletable?.onTodoDeleted(todo: todo, todos: model.todos)
            
        }
        
    }
    
    
    
}
