//
//  TodoVIPER.swift
//  PracticaVIPER
//
//  Created by
//

import Foundation
import UIKit

// MARK: [1] Entity
// Modela los datos(titulo, checked) de un "Todo"
struct TodoEntity {
    
    let title: String
    var checked: Bool = false
    
}

// MARK: [2] Interactor
// Interactua con los datos de la entidad, retiene el modelo y realiza toda lalogica (tareas)
// Es similar a tener un mecanismo CRUD o similar, que se aplica sobre nuestras entidades y tiene el objetivo
// de administrar la lógica de negocio, de API y hacia al base de datos que sea necesaria.
// Para datos locales, el interactor simplemente administrará los arreglos de datos generalmente.
class TodoInteractor {
    
    // Arreglo para almacenar los "Todos" creados
    var todos: [TodoEntity] = [TodoEntity(title: "Pagar el agua"),
                               TodoEntity(title: "Comprar aceite")]
    
    // Agregar un "Todo", recibiendo un titulo
    func addTodo(title: String) {
        
        let todo = TodoEntity(title: title)
        self.todos.append(todo)
    }
    
    // Obtiene algun "Todo" a partir de un inidce(index) dado, que exista en el arrreglo "todos"
    func getTodo(index: Int) -> TodoEntity? {
        return self.todos[index]
    }
    
    // Cacmbiar el estado(checked) del "Todo" a true en algun inidce dado, sobre el arreglo "todods"
    func checkTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = true
        self.todos[index] = todoUpdated
    }
    
    // Cacmbiar el estado(checked) del "Todo" a false en algun inidce dado, sobre el arreglo "todods"
    func uncheckTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = false
        self.todos[index] = todoUpdated
    }
    
    // Elimina un "Todo" a partir de un indice(index) dado
    func deleteTodo(index: Int) {
        self.todos.remove(at: index)
    }
}

// MARK: [3] Presenter
// Generalmente es de tipo "NSObject" para permitir controlar cosas complejas como un UITable. Este
// Debera inicializar el "interactor" y al "router"
// Tambien debera decirle al "router" quien es el para que haya comunicacion "binding two-way", es decir, el "presenter" conoce al "router" (el lo crea) y el "router" conoce al "presenter" en fomra debil.
// Presenta los datos a las vistas y de tal forma que si la vista necesita algo del interactor(modelo de datos), entonces
// este los presentara de forma sencilla.
// Es como un puente entre la vista, el interactor y el router y reune todas las operaciones de logica y navegacion en un
// unico componente (una sola capa)
// Aqui generalmente no habra codigo complejo, sino mas bien conexxiones y propagaciones de datos hacia el interactoro router
// Por ejemplo, el preseter permite agregar un "Todo" y se lo pasa al interactor y permite navegar a la vista de "TodoAdd"
// Y se lo pasa al router.
class TodoPresenter: NSObject {
    
    // Es una referencia fuerte, inmutable hacia un "Interactor"
    let interactor: TodoInteractor
    // Es una referencia fuerte, inmutable hacia un "Router"
    var router: TodoRouter?
    // Es una referencia debil, mutable hacia una "vista"
    var viewController: TodoViewController?
    
    override init() {
        // Instancia de TodoInteractor
        self.interactor = TodoInteractor()
        super.init()
    }
}

// Extension de TodoPresenter para implementar UITableViewDataSource, UITableViewDelegate
extension TodoPresenter: UITableViewDataSource, UITableViewDelegate {
    
    // Numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Titulo de la seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos"
    }
    
    // Numero de filas de la seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.todos.count
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Recupera la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
        // TODO Configurar celda
        /*if let cell = cell as? TodoTableViewCell, let todo = self.interactor.getTodo(index: indexPath.row) {
            cell.leftLabel.text = todo.title
            cell.rightLabel.text = todo.checked ? "ok" : "noOk"
        }*/
        return cell
    }
}

// MARK: [4] Router
// Encargado de la navegación entre vistas (ViewControllers) y de pasar datos entre vistas. Su objetivo es
// controlar los "segues" y dejar configurado al presenter, tiene que conocer a la vista (ViewController) de manera debil.
// Generalmente se definen dos tipos de router: "Main Router", "Secondary Router"
// El "Main Router" controla el "Root ViewCOntroller" que es el prinicipal y encargado de los "segues"
// EL "Secondary Router" controla cualquier otro "ViewCOntroller" que ya no es el prinicpal (no tiene segues)

// El router parte de un protocolo que establece requerir un "presenter" y dos vistas, la vista anterior (de donde
// proviene la navegacion) y la vista actual (hacia donde se hizo la navegacion)
protocol TodoRouter {
    
    var presenter: TodoPresenter? { get set }
    var lastViewController: UIViewController? { get set }
    var currentViewController: UIViewController? { get set }
}

// Main Router
class TodoMainRouter: UIViewController, TodoRouter {
    
    // El presenter es instanciado por la vista principal y no puede ser debil
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
            if let todoDetailViewController = segue.destination as? TodoAddViewController {
                self.lastViewController = self.currentViewController
                self.currentViewController = todoDetailViewController
                self.presenter?.viewController = todoDetailViewController
                todoDetailViewController.presenter = self.presenter
            }
        default:
            print("Invalid segue")
        }
    }
    // Metodos para navegar de la vista principal a las otras vistas
    
    func showAddTodo() {
        self.performSegue(withIdentifier: "TodoAddSegue", sender: self)
    }
    
    func showDetailTodo() {
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: self)
    }
}

// Secondary Router: es la navegacion entre las vistas siguientes y las anteriores
class TodoSecondaryRouter: UIViewController, TodoRouter {
    
    var presenter: TodoPresenter?
    var lastViewController: UIViewController?
    var currentViewController: UIViewController?
    
}

// MARK: [5] View
// Muestra en la interfaz la información que llega desde el presenter y recoger eventos del usuario delegándolos
// al presentador.

// Protocolo que representa una visat en general, aqui definimos que cualquier vista conoce a su presenter y a su router
protocol TodoViewController {
    
    var presenter: TodoPresenter? { get set }
    var router: TodoRouter? { get set }
    
}


// Las vistas derivan directamente de algun router, ya sea el main router o el secondary router
// La vista principal creara
class TodoHomeViewController: TodoMainRouter, TodoViewController {
    
    var router: TodoRouter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.presenter = TodoPresenter()
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.lastViewController = self
        self.router?.currentViewController = self
        
    }
}

// Solo navegacion hacia atras
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

// Solo navegacion hacia atras
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
