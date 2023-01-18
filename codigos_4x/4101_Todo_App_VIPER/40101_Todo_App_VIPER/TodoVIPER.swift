//
//  TodoVIPER.swift
//  40101_Todo_App_VIPER
//
//  Created by Dragon on 26/12/22.
//

import Foundation
import UIKit

///
/// Modela los datos de una entidad **Todo** (`title` y `checked`)
///
/// Retiene los datos importantes sobre las entidades que estemos utilizando en el proyecto.
///
/// Por ejemplo, para retner los datos de un *Producto*, los datos de una *Respuesta*, etc.
///
struct TodoEntity {
    let title: String
    var checked: Bool = false
}

///
/// Interactua con los datos de la entidad, retiene el modelo y trabaja sobre él
///
/// El interactor es similar a tener un mecanismo CRUD o similar que se aplica sobre nuestras entidades
/// y tiene el objetivo de administrar la lógica de negocio, de API y de base de datos que sea necesaria.
///
/// Para datos locales, el interactor simplemente administrará los arreglos de datos generalmente.
///
class TodoInteractor {
    
    /// Un arreglo de entidades **Todo**
    var todos: [TodoEntity] = [
        TodoEntity(title: "Comprar leche", checked: false),
        TodoEntity(title: "Comprar fruta", checked: true),
        TodoEntity(title: "Comprar refresco", checked: false)
    ]
    
    /// Agrega un nuevo **Todo** sólo con `title`
    /// - parameters:
    ///     - title: El título del nuevo **Todo**
    func addTodo(title: String) {
        let todo = TodoEntity(title: title)
        self.todos.append(todo)
        print("Se agregó el todo: \(todo)")
    }
    
    /// Recupera el **Todo** en la posición indicada del arreglo
    /// - parameters:
    ///     - index: El índice del **Todo** en el arreglo
    func getTodo(index: Int) -> TodoEntity? {
        return self.todos[index]
    }
    
    /// Actualiza el estado `checked` a `true` del **Todo** en un índice dado sobre el arreglo
    /// - parameters:
    ///     - index: El índice del **Todo** sobre el arreglo
    ///     - todo: Los datos del **Todo** anterior a reemplazar
    func checkTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = true
        self.todos[index] = todoUpdated
    }
    
    /// Actualiza el estado `checked` a `false` del **Todo** en un índice dado sobre el arreglo
    /// - parameters:
    ///     - index: El índice del **Todo** sobre el arreglo
    ///     - todo: Los datos del **Todo** anterior a reemplazar
    func uncheckTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = false
        self.todos[index] = todoUpdated
    }
    
    /// Elimina **Todo** en un índice dado sobre el arreglo
    /// - parameters:
    ///     - index: El índice del **Todo** sobre el arreglo
    func deleteTodo(index: Int) {
        self.todos.remove(at: index)
    }
    
}

///
/// Le presenta los datos a las vistas (`ViewControllers`) de tal forma que si la *vista* necesita algo del
/// *interactor* (del modelo de datos), entonces este los presentará de una forma sencilla
///
/// El presenter es como puente entre la *vista*, el *interactor* y el *router* (el navegador) y reune todas las operaciones
/// de lógica y navegación en  un único componente (en una sola capa).
///
/// Aquí generalmento no habrá código complejo, sino más bien conexiones y propagaciones de datos hacía el
/// *interactor* o el *router*.
///
/// Por ejemplo, el *presenter* permite agregar un **Todo** (y se lo pasa al *interactor*) y permite navegar
/// a la *vista* de *Todo Add* (y se lo pasa al *router*).
///
class TodoPresenter: NSObject {
    
    /// Es una referencia fuerte, inmutable hacía un *interactor*
    let interactor: TodoInteractor
    
    /// Es una referencia, mutable hacía un *router*
    var router: TodoRouter?
    /// Es una referencia, mutable hacía una *vista*
    var viewController: TodoViewController?
    
    ///
    /// El *presenter* generalmente es de tipo `NSObject` para permitir
    /// controlar cosas complejas como un `UITableView`. Este deberá inicializar
    /// el *interactor* y al *el router*.
    ///
    override init() {
        self.interactor = TodoInteractor()
        super.init()
    }
    
    // TODO: Agregar los métodos para consumir el interactor y el router
    
}

// TODO: Controlar el UITableViewDataSource y UITableViewDelegate
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
        // TODO: Configurar la celda
        if let cell = cell as? TodoTableViewCell, let todo = self.interactor.getTodo(index: indexPath.row) {
            cell.leftLabel.text = todo.title
            cell.rightLabel.text = todo.checked ? "✅" : "❌"
        }
        return cell
    }
    
}

///
/// El *router* parte de un protocolo que estable requerir un *presenter*
/// y dos *vistas*, la *vista* anterior (de dónde proviene la navegación)
/// y la *vista* actual (hacía dónde se hizo la navegación)
///
/// Generalmente se definen dos tipos de routers:
/// * **Main Router** - Controla el `Root ViewController` que es el principal y encargado de los *segues*
/// * **Secondary Router** - Controla cualquier otro `ViewController` que ya no es el principal
///                         (no tiene *segues*)
///
protocol TodoRouter {
    var presenter: TodoPresenter? { get set }
    var lastViewController: UIViewController? { get set }
    var currentViewController: UIViewController? { get set }
}

///
/// Es el reponsable de guiar la navegación entre *vistas* (entre `ViewControllers`)
/// y su objetivo es controlar los *segues* y dejar configurados correctamente al presenter.
///
class TodoMainRouter: UIViewController, TodoRouter {
    
    /// El presenter es instanciado por la *vista* principal y no puede ser débil
    var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "TodoAddSegue":
            if let todoAddViewController = segue.destination as? TodoAddViewController {
                self.lastViewController = self.currentViewController
                self.currentViewController = todoAddViewController
                self.presenter?.viewController = todoAddViewController
                todoAddViewController.presenter = self.presenter
            }
        case "TodoDetailSegue":
            if let todoDetailViewController = segue.destination as? TodoDetailViewController {
                self.lastViewController = self.currentViewController
                self.currentViewController = todoDetailViewController
                self.presenter?.viewController = todoDetailViewController
                todoDetailViewController.presenter = self.presenter
            }
        default:
            print("Invalid segue")
        }
        
    }
    
    // TODO: Poner los métodos para navegar de la vista principal a los otras vistas
    func showAddTodo() {
        self.performSegue(withIdentifier: "TodoAddSegue", sender: self)
    }
    
    func showDetailTodo() {
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: self)
    }
    
}

/// Es la navegación entre las vistas siguientes y las anteriores
class TodoSecondaryRouter: UIViewController, TodoRouter {
    
    weak var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
    
    // TODO: Poner los métodos para regresar al vista principal
    
}

///
/// El el protocolo que representa una *vista* en general
///
/// Aquí definimos que cualquier *vista* conoce a su *presenter* y a su *router*
///
protocol TodoViewController {
    
    var presenter: TodoPresenter? { get set }
    var router: TodoRouter? { get set }
    
}

///
/// Las *vistas* derivan directamente de algún *router*, ya sea el **main router** o el **secondary router**
///
/// La vista principal creará un presenter nuevo y configurará el router
///
class TodoHomeViewController: TodoMainRouter, TodoViewController {
    
    var router: TodoRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodoPresenter() // MAIN
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.lastViewController = self // MAIN
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
