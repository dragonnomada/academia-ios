import Foundation

struct Todo {
    let title: String
    let checked: Bool
}

class TodoModel {
    
    var todos: [Todo] = []
    
}

protocol TodoViewDelegate {
    
    func todo(todoAdded todo: Todo)
    
}

class TodoController {
    
    static let shared = TodoController()
    
    var model = TodoModel()
    
    var delegate: TodoViewDelegate?
    
    func addTodo(title: String) {
        print("Controlador: Creando nuevo Todo")
        
        let todo = Todo(title: title, checked: false)
        
        print("Agregando Todo al modelo")
        
        self.model.todos.append(todo)
        
        print("Notificando a la vista que el Todo ha sido creado")
        
        if let delegate = self.delegate {
            print("Se le envia a la vista el Todo agregado")
            
            delegate.todo(todoAdded: todo)
        } else {
            print("No hay ninguna vista que se haya conectado para el resultado de haber creado el Todo")
        }
    }
    
}

class TodoView {
    
    init() {
        //TodoController.shared.delegate = self
    }
    
    func addTodo() {
        TodoController.shared.addTodo(title: "Hola mundo")
    }
    
}

extension TodoView: TodoViewDelegate {
    
    func todo(todoAdded todo: Todo) {
        print("El todo ha sido agregado: \(todo)")
    }
    
}

let view = TodoView()

view.addTodo()

