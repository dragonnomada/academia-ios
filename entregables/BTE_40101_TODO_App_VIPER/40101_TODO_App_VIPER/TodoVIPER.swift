//
//  TodoVIPER.swift
//  40101_TODO_App_VIPER
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit

///
/// Modela los datos de un ToDo (title y checked)
///
struct TodoEntity {
    let title: String
    var checked: Bool = false
}

///
/// Interactua con los datos de la entidad, retiene el modelo y trabaja sobre el.
///
/// El interactor es similar a tener un mecanismo CRUD o similiar que se aplica sobre nuestras entidades y tiene el objetivo de
/// administrar la logica del negocio, de API y hacía la base de dattos de otro que sea necesaria.
///
/// para datos locales, el intercactor simplemente administrará los arreglos de datos generalmente.
///
class TodoInteractor {
    /// Un arreglo de entidades ToDo
    var todos: [TodoEntity] = [
        TodoEntity(title: "Comprar Fruta"),
        TodoEntity(title: "Comprar Refresco"),
        TodoEntity(title: "Lavar"),
        TodoEntity(title: "Limpiar Cocina"),
        TodoEntity(title: "Proyecto Final"),
        TodoEntity(title: "Practica")
    ]
    
    /// Agrega un nuevo ToDo solo con el título
    ///  - parameters:
    ///     - title: El título del nuevo  **ToDo**
    func addTodo(title: String){
        let newTodo = TodoEntity(title: title)
        self.todos.append(newTodo)
    }
    
    /// Recupera el **ToDo** en la posición indicada del arreglo
    /// - parameters:
    ///     - index : El índice del **ToDo** en el arreglo
    func getTodo(index: Int) -> TodoEntity? {
        return self.todos[index]
    }
    /// Actualiza el empleado checked a **true** del **ToDo**  en un inidice dado sobre el arreglo
    /// - parameters:
    ///     - índex: El índice del **ToDo** sobre el arreglo
    ///     - todo: Los datos del **ToDo** anterior a reemplazarlo
    func checkTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = true
        self.todos[index] = todoUpdated
    }
    /// Actualiza el empleado checked a **false** del **ToDo**  en un inidice dado sobre el arreglo
    /// - parameters:
    ///     - índex: El índice del **ToDo** sobre el arreglo
    ///     - todo:Los datos del **ToDo** anterior a reemplazarlo
    func uncheckTodo(index: Int, todo: TodoEntity) {
        var todoUpdated = todo
        todoUpdated.checked = false
        self.todos[index] = todoUpdated
    }
    
    func deleteTodo(index: Int, todo: TodoEntity) {
        self.todos.remove(at: index)
    }
}


///
/// Presenta los datos a las vistas  (viewControllers) y de tal forma que si la vista necesita algo del interactor es decir, del modelo de
/// datos, eontoncese el presenter los presentara de una forma sencilla
///
/// El presenter es como un puente entre la vista, el interactor y el router (el navegador) y reune todas las operaciones de lógica
/// y navegación en un único compenente (en una sola capa)
///
/// Aquí generalemente no habrá codifo complejo, sino conexiones y propagaciones de datos hacía el interactor o el router.
///
/// Por ejemplo el *presenter* permite agregar un *ToDo* y se lo pasa al interactor y permite navegar a la vista de *Todo Add* y se lo pasa al *router*
class TodoPresenter : NSObject {
    static let shared = TodoPresenter()
    /// Es una referencia fuerte, inmutable hacía un *interactor*
    let interactor: TodoInteractor
    /// Es una referencia, inmutable hacía un *router*
    var router: TodoRouter?
    /// Es una referencia, mutable hacía una *vista*
    var viewController: TodoViewController?
    
    ///
    /// El *presenter* generalmente es de tipo NSObject para permitir controlar cosas complejas
    /// como un UITableView. Este debera inicializar el *interactor* y el *router*
    ///
    ///  Tambien deberá decirle al *router* quién es el para que haya comunicacíon *binding two-way*
    ///  es decir, el *presenter* conoce al *router* (él lo crea) y el *router* conoce al *presenter* en forma debil..
    override init() {
        self.interactor =  TodoInteractor()
        super.init()
    }
}

extension TodoPresenter : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "To-Dos"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
        // TODO: Configurar celda personalizada
        return cell
    }
    
    
}
// TODO: Controlar el UITableViewDataSours Delegate extension

///
/// Es el responsable de guiar la navegación entre vistas (ViewControllers)
/// y su objetivo es controlar los segues y dejar configurados correctamente al presenter.
///
/// Generalmente se definen 2 tipos de routers:
///     **Main Router** - Controla el Root ViewController que es el principal y encargado de los segues
///     **Secondary Router** - Controla cualquier otro ViewController que ya no sea el principal (no tiene segues)
///

///
/// El *router parte* de un protocolo que establece requerir un *presenter*
/// y dos *vistas*, la *vista* anterior (de donde  proviene la navegacion)
/// y la *vista* actual (hacía dónde se hizo la navegación.
///
protocol TodoRouter {
    var presenter: TodoPresenter? { get set }
    var lastViewController: UIViewController? { get set }
    var currentViewController: UIViewController? { get set }
}


class TodoMainRouter: UIViewController, TodoRouter {
    
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
            print("Invalid Segue")
        }
    }
    
    func showAddTodo(){
        self.performSegue(withIdentifier: "TodoAddSegue", sender: self)
    }
    
    func showDetailTodo(){
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: self)
    }
    
//    TODO: Métodos para navegar de la vista principal a las otras vistas
}
/// Es la navegación entre las vistas siguientes y las anteriores
class TodoSecondaryRouter: UIViewController, TodoRouter {
    weak var presenter: TodoPresenter?
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
    
//    TODO: Métodos para regresar a la vista principal
}

///
/// Aquí definimos que cualquier *vista* conoce a su *presenter* y su *router*
///
protocol TodoViewController {
    var presenter: TodoPresenter? { get set }
    var router: TodoRouter? { get set }
}

///
/// Las vistas derivan directamente de algun *router* ya sea e l **main-router** o el **secondary router**
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
