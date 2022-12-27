//
//  TodoVIPER.swift
//  ToDoApp
//
//  Created by User on 26/12/22.
//

import Foundation
import UIKit

///
///Todo App Viper
///

///
///Modela los datos de un Todo ('title' y 'cheked')
///
struct TodoEntity {
    let title: String
    var checked: Bool = false
}

///
///Interactua con los datos de la Entidad, retiene el modelo y trabaja sobre él
///
///El interactor es similar a tener un mecanismo CRUD o similar que se aplica sobre nuestras entidades
///y tiene el objetivo de administrar la lógica de negocio, de API y de base de datos que sea necesaria.
///Para datos locales, el interactor simplemente administrará los arreglos de datos generalmente.
///
class TodoInteractor {
    
    /// Un arreglo de entidades Todo
    //var todos: [TodoEntity] = []
    var todos: [TodoEntity] = [
        TodoEntity(title: "comprar leche", checked: false),
        TodoEntity(title: "comprar fruta", checked: true),
        TodoEntity(title: "comprar refresco", checked: false)
    ]
    
    ///Agrega un nuevo *Todo* sólo con 'title'
    ///- parameters:
    /// - title: El título del nuevo **Todo**
    func addTodo(title: String) {
        let todo = TodoEntity(title: title)
        todos.append(todo)
    }
    
    ///Recupera el **todo** en la posición indicada del arreglo
    ///- parameters:
    ///  - index: El índice del **Todo** en el arreglo
    func getTodo(index: Int) -> TodoEntity? {
        return todos[index]
    }
    
    ///Actualiza el estado `checked`del **Todo** en un índice dado sobre el arreglo
    ///- parameters:
    /// - index: El índice del **Todo** sobre el arreglo
    /// - todo: Los datos del **Todo** a actualizar
    func checkTodo(index: Int, todo: TodoEntity) {
        var todoUpdate = todo
        todoUpdate.checked = true
        todos[index] = todoUpdate
    }
    
    ///Actualiza el estado `checked`del **Todo** en un índice dado sobre el arreglo
    ///- parameters:
    /// - index: El índice del **Todo** sobre el arreglo
    /// - todo: Los datos del **Todo** a actualizar
    func uncheckTodo(index: Int, todo: TodoEntity) {
        var todoUpdate = todo
        todoUpdate.checked = false
        self.todos[index] = todoUpdate
    }
    
    ///Elimina el **todo** en la posición indicada del arreglo
    ///- parameters:
    ///  - index: El índice del **Todo** en el arreglo
    func deleteTodo(index: Int) {
        self.todos.remove(at: index)
    }
}

///Le presenta los datos a las vistas (´ViewControllers´) de tal forma que si la *vista* necesita algo del
///interactor ( del modelo de datos), entonces este los presentará de una forma sencilla.
///
///El presenter es como un puente entre la *vista*, el *interactor* y el *router* (el navegador) y reune todas las operaciones
///de lógica y navegación en un único componente (en una sola capa).
///
///Aquí generalmente no habrá código complejo, sino más bien conexiones y propagaciones de datos hacia el interactor o el router
///Por ejemplo, el *presenter* permite agregar un **Todo** (y se lo pasa al *interactor*) y permite navegar
///a la *vista* de *Todo Add* (y se lo pasa al *router*).
class TodoPresenter: NSObject {
    
    /// Es una referencia fuerte, inmutable hacía el interactor
    let interactor: TodoInteractor
    /// Es una referencia débil, inmutable hacia el *router*
    var router: TodoRouter?
    /// Es una referencia débil, mutable hacía una *vista*
    var viewController: TodoViewController?
    
    ///
    ///El *presenter* generalmente es de tipo NSObject para permitir controlar cosas complejas como un
    ///´UITableView´. Este deberá inicializar el *interactor* y al *router*.
    ///
    override init() {
        self.interactor = TodoInteractor()
        super.init()
    }
}

extension TodoPresenter: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
        return cell
    }
}

///
///El *router* parte de un protocolo que establece requerir un *presenter*
///y dos *vistas*, la *vista* anterior (de donde proviene la navegación)
///y la *vista* actual (hacia donde se hizo la navegación
///
///Generalmente se definen dos tipos de routers:
///* **Main Router** - Controla el ´Root ViewController´que es el principal y encargado de los *segues*
///* **Secondary Router** - Controla cualquier otro ´ViewController´que ya no es el principal
///
protocol TodoRouter {
    var presenter: TodoPresenter? { get set }
    var lastViewController: UIViewController? { get set }
    var currentViewController: UIViewController? { get set }
}

///
///Es el responsable de guiar la navegación entre *vistas* (entre ´ViewControllers´)
///y su objetivo es controlar los *segues* y dejar configurados correctamente al *presenter*.
///
class TodoMainRouter: UIViewController, TodoRouter {
    ///El presenter es instanciado por la *vista* principal y no puede ser débil.
    var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "TodoAddSegue": if let todoAddViewController = segue.destination as? TodoAddViewController {
                self.lastViewController = self.currentViewController
                self.currentViewController = todoAddViewController
                self.presenter?.viewController = todoAddViewController
            }
        case "TodoDetailSegue": if let todoDetailViewController = segue.destination as? TodoDetailViewController {
                self.lastViewController = self.currentViewController
                self.currentViewController = todoDetailViewController
                self.presenter?.viewController = todoDetailViewController
            }
        default :
            print("Invalid Segue")
        }
    }
    
    func showAddTodo() {
        self.performSegue(withIdentifier: "TodoAddSegue", sender: self)
    }
    
    func showDetailTodo() {
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: self)
    }
}

///Es la navegación entre las vistas siguientes y las anteriores
class TodoSecondaryRouter: UIViewController, TodoRouter {
    
    weak var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
}
///Es el protocolo que representa una *vista* en general
///
///Aquí definimos que cualquier vista conoce a su *presenter* y a su *router*
protocol TodoViewController {
    var presenter: TodoPresenter? { get  set }
    var router: TodoRouter? { get set }
}

///Las *vistas* derivan directamente de algún router, ya sea el **main router** o el **secondary router**
///
///La vista principal creará un presenter nuevo y configurará el router
///
class TodoHomeViewController: TodoMainRouter, TodoViewController {
    var router: TodoRouter?
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodoPresenter()
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.lastViewController = self
        self.router?.currentViewController = self
    }
}

class TodoAddViewController: TodoSecondaryRouter, TodoViewController {

    var router: TodoRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.currentViewController = self
    }
}

class TodoDetailViewController: TodoSecondaryRouter, TodoViewController {
    
    var router: TodoRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.currentViewController = self
    }
}

