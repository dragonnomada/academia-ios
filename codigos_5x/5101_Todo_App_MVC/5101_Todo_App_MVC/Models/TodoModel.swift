//
//  TodoModel.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import Foundation
import CoreData

/// El modelo reprensenta los datos que serán retenidos
/// durante la ejecución y la forma de recuperarlos, actualizarlos,
/// eliminarlos o generar nuevos datos.
///
/// **Nota:** Los modelos se dicen pasivos, porque no dependen
///         de otros componentes, es decir, funcionan de forma
///         aislada y sólo si otro componente lo utiliza hace algo.
class TodoModel {
    
    /// Establecemos el contenedor de *CoreData* asociado al modelo
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor \(error)")
            }
        }
        
        return container
    }()
    
    /// Retenemos una lista de `TodoEntity`
    var todos: [TodoEntity] = []
    
    /// Recupera todos los `todos` desde el *CoreData*
    func loadTodos() {
        
        let context = self.persistentContainer.viewContext
        
        let requestTodos = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(requestTodos) {
            
            self.todos = todos
            
        }
        
    }
    
    /// Devolvemos el `TodoEntity?` de un ìndice
    func getTodo(index: Int) -> TodoEntity? {
        
        guard index >= 0 && index < self.todos.count else { return nil }
        
        return self.todos[index]
        
    }
    
    /// Agregamos un nuevo `todo` al *CoreData*
    func addTodo(title: String) -> TodoEntity? {
        
        print("Agregando Todo \(title)")
        
        let context = self.persistentContainer.viewContext
        
        let todo = TodoEntity(context: context)
        
        todo.id = Int32.random(in: 1...1_000_000)
        todo.title = title
        todo.checked = false
        todo.createAt = Date.now
        
        do {
            try context.save()
            self.loadTodos()
            return todo
        } catch {
            context.rollback()
            return nil
        }
        
    }
    
    /// Actualizamos el *title* de un `todo`
    func updateTodoTitle(index: Int, title: String) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.title = title
            todo.updateAt = Date.now
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
    /// Actualizamos el *checked* de un `todo`
    func updateTodoCheck(index: Int, checked: Bool) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.checked = checked
            todo.updateAt = Date.now
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
    /// Eliminamos un `todo`
    func deleteTodo(index: Int) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            let context = self.persistentContainer.viewContext
            
            context.delete(todo)
            
            do {
                try context.save()
                self.loadTodos()
                return todo
            } catch {
                context.rollback()
            }
            
        }
        
        return nil
        
    }
    
}
