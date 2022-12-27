//
//  TodoViper.swift
//  TodoApp_NJJ_
//
//  Created by MacBook on 26/12/22.
//
///Joel Brayan Navor Jimenez
///Todo AppVIPER
///

import Foundation
import UIKit


 ///Modela los datos de un Todo
///- parameters:
///         title: Representa el titulo de algo por hacer
///         checked: Representa el estado de algo por hacer
struct TodoEntity {
    let title: String
    var checked: Bool = false
}

///Interactua con los datos de la entidad, retiene el modelo y trabaja sobre èl
///
///El interactor es similar a tener un mecanismo CRUD o similar que se aplica sobre nuestras entidades y tiene el objetivo de administrar la lògica de negocio, de API y hacia la base de datos necesaria.
/// Para datos locales, el interactor simplemente administrara los arreglos de datos generalmente.

class TodoInteractor {
    ///Un arreglo de entidades todo
    var todos: [TodoEntity] = [TodoEntity(title: "Comprar Leche"), TodoEntity(title: "Ir al Gym"), TodoEntity(title: "Lavar Ropa"), TodoEntity(title: "Preparar Comida")]
    
    
    
    ///Agrega un nuevo **todo** solo con el 'tìtle'
    /// -parameters
    ///     -title: El tìtulo del nuevo **Todo**
    func addTodo(title: String) {
        let newtodo = TodoEntity(title: title)
        self.todos.append(newtodo)
    }
    
    ///Recupera el **Todo** en la posiciòn indicada del arreglo
    ///- Parameters:
    ///        -index: El ìndice del **Todo** en el arreglo
    func getTodo(index: Int) -> TodoEntity? {
        return todos[index]
    }
    
    ///Actualiza el estado `checked` del **Todo** en un ìndice dado sobre el arreglo
    ///- Parameters:
    ///     -ìndex: El ìndice del **Todo** sobre el arreglo
    ///     -todo: Los datos del **Todo** anterior a reemplazar
    ///     - cambia el estado del **Todo** a true (Activado)
    func checkTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = true
        self.todos[index] = todoUpdated
    }
    
    ///Actualiza el estado `checked` del **Todo** en un ìndice dado sobre el arreglo
    ///- Parameters:
    ///     -ìndex: El ìndice del **Todo** sobre el arreglo
    ///     -todo: Los datos del **Todo** anterior a reemplazar
    ///     - cambia el estado del **Todo** a true (Activado)
    func uncheckTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = false
        self.todos[index] = todoUpdated
    }
    
    ///Elimina el **Todo** indicado por el indice en el index
    func deleteTodo(index: Int) {
        self.todos.remove(at: index)
    }
    
}
///Le presenta los datos a las vistas ( `ViewControllers` ) de tal forma que si a vista necesita algo del interactor (del modelo de datos), entonces este los presentarà de una forma sencilla.
///
///El presenter ees como un puente entre la vista, el interactor y el router (el navegador) y reune todas las operaciones del lògica y navegaciòn en un unico componente (en una sola capa).
///
///Aqui generalmente no habra codigo complejo, si no  màs bien  conexiones y propagaciones de datos hacìa  el interactor o el *router*.
///
///Por ejemplo el *presenter * permite agregar un *Todo* (y se lo pasa al *interactor*) y permite navegar a la *vista* de *Todo Add* (y se lo pasa al *router*).

class TodoPresenter:NSObject {
    
    /// Es una referencia fuerte, inmutable hacìa el interactor
    let interactor: TodoInteractor
    
    /// Es una referencia debil, mutable hacìa un *router*
     var router: TodoRouter?
    
    /// Es una referencia dèbil, mutable hacia una *vista*
     var viewController: TodoViewController?
    
    /// El *presenter* generalmente es de tipo `NSObject` para permitir controlar cosas complejas como el `UITableView`. Este deberà inicializar el *interactor* y al *router*.

    
    override init() {
        self.interactor = TodoInteractor()
        super.init()
    }
    

    
//    func showAddTodo() {
//        router.showAddTodo(viewController: viewController)
//    }
}
/// El *router* parte de un protocolo que establece requerir un *presenter* y dos *vistas*, la *vista*

extension TodoPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
        ///**Todo** Configurar la celda
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos"
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}


protocol TodoRouter {
    var presenter: TodoPresenter? { get set }
    var lastViewController: UIViewController? { get set }
    var currentViewController: UIViewController? { get set }
}

/// Es el responsable de guiar la navegaciòn entre vistas (entre `ViewControllers`)
/// y su objetivo es controlar los *segues* y dejar configurados correcctamente al presenter.
///
/// Generalmente se definen doos tipos de routers:
/// * **MainRouter** - Controla el `Root ViewController` que es el principal y encargado de los *segues*.
/// * **SecondaryRouter** - Controla cualquier otro `ViewController` que ya no es el principal (no tiene *segues*)


class TodoMainRouter: UIViewController, TodoRouter   {
        
    var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    
    weak var currentViewController: UIViewController?
    
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TodoAddSegue" {
            if let todoAddViewController = segue.destination as? TodoAddViewController {
                self.lastViewController = currentViewController
                self.currentViewController = todoAddViewController
                self.presenter?.viewController = todoAddViewController
                todoAddViewController.presenter = self.presenter
            }
        }
        if segue.identifier == "TodoDetailSegue" {
            if let todoDetailViewController = segue.destination as? TodoDetailViewController {
                self.lastViewController = currentViewController
                self.currentViewController = todoDetailViewController
                self.presenter?.viewController = todoDetailViewController
                todoDetailViewController.presenter = self.presenter
            }
           
        }
       
    }
    // TODO: Poner los mètodos para navegar de la vista principal a las otras vistas
    func showDetailTodo() {
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: nil)
    }
    func showAddTodo() {
        self.performSegue(withIdentifier: "TodoAddSegue", sender: nil)
    }
    
}

class TodoSecondaryRouter: UIViewController, TodoRouter {
    
    
    weak var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    
    weak var currentViewController: UIViewController?
    
    
}


/// Es el protocolo que representa una *vista* en general
///
/// Aqui definimos que cualquier *vista* conoce a su *presenter* y a su *router*
protocol TodoViewController {
    
    var presenter: TodoPresenter? { get set }
    var router: TodoRouter? { get set }
    
}

/// Las vistas derivan directamente de algùn *router*, ya sea el **main router** o el **secondary router**
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

class TodoHomeViewController: TodoMainRouter, TodoViewController {
    
    var router: TodoRouter?
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodoPresenter() // Main
        self.presenter?.viewController = self
        self.router = self
        self.presenter?.router = self
        self.router?.lastViewController = self
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


