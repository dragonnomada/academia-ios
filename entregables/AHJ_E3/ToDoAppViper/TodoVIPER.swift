//
//  TodoVIPER.swift
//  ToDoAppViper
//
//  Created by MacBook  on 26/12/22.
//

import Foundation
import UIKit

///
///Modela los datos de un todo(title y checlked)
///
///
struct TodoEmtity {
    let title: String
    var checked: Bool = false
}


///
/// interactuar con los datos de la entidad, retiene el modelo y trabaja sobre el
/// el interarctor es similar a tener a un mecanismo de crud o similar que se aplica sobre nuestras entidades
/// y tiene el mismo objetivo de admistar nuestra logoca de negocio, de api y hacia la base de dartos que sean necesarias
///
///
class TodoInteractor{
    
    var todos2: [TodoEmtity] = [
        
    ]
    ///
    ///un arreglo de entidades todo
    ///
    var todos: [TodoEmtity] = [
        TodoEmtity(title: "ALGO", checked: false),
        TodoEmtity(title: "algo2", checked: true)
    ]
    
    ///
    ///agregar un todo
    ///
    func addTudo(title: String){
        let todo = TodoEmtity(title: title)
        todos.append(todo)
    }
    ///
    ///recuperar un todo
    ///
    func getTodo(index:Int) -> TodoEmtity? {
        return todos[index]
    }
    ///
    ///actualiza un todo
    ///parametros:
    ///
    ///
    func checkTodo(index: Int, todo: TodoEmtity){
        var todoUpdate = todo
        todoUpdate.checked = true
        self.todos[index] = todoUpdate
    }
    ///
    ///lo contrario al checked
    ///
    func unCheckTodo(index: Int, todo: TodoEmtity){
        var todoUpdate = todo
        todoUpdate.checked = false
        self.todos[index] = todoUpdate
    }
    ///
    ///eliminamos un todo en la posicion indicada del arreglo
    ///
    func detailTodo(index: Int){
        self.todos.remove(at: index)
    }
    
}


///
///le presenta los datos a las vitas(viewcontroller)y de tal forma que si la vistra necesita
///algo del interactos(del modelo de datos), entonces el presenter los va a presentar una forma sencilla
///
///el presenter es como un puente entre la vista el interactor y el router
///es decir el navigador y reune todas las operaciones de logica y negociacion en un unico cpomponente(en una sola capa)
///
///aqui generalmente ho habra codigo complejo, sino mas bien coneccionaes y propagaciones de datos haciea el interactor o el rauter
///
///por ejemplo el presenter permite generar un todo(y se lo pasa al intercator) y permitre navigar a al vista de todo add
///(y se lo pase al rauter)
///
class TodoPresenter: NSObject {
    
    ///
    ///es una referencia fuerte unmutable hacia el interactor
    ///
    let interactor: TodoInteractor
    ///
    ///es una referencia fuerte hacia el rauter
    ///
    var router: TodoRouter?
    
    ///
    ///es una referencia debeil hacia la vsita
    ///
    var viewController: TodoViewController?
    
    ///
    ///el presenter genera un tipo de NSObject para permitir
    ///controlar cosas complejas como un UItableView esta deveria inicializarse en el interacrtor y en el rauter
    ///
    ///tambien
    ///
    ///
    override init(){
        
        self.interactor = TodoInteractor()
        super.init()
//        self.viewController?.presenter = self
//        viewController!.presenter = self
    }
    
    
}
extension TodoPresenter: UITableViewDataSource, UITableViewDelegate{
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
        //TODO: hacer la celda
        return cell
    }
}
///
///es el reposnsable de guiar la navegacion entre vistas entre view controller
///y su objetivo es controlar los sigues
///y dejar configurados
///correctamente al presenter
///
///generalmente se define dos tipos de rauters a saber al mean router y second rauter
///
///el MAIN router controla el root viewController que es el principal y encargado de los segues
///el second router se encarga de
///
class TodoMainRouter: UIViewController, TodoRouter {
   
    /// no puede ser debil
    var presenter: TodoPresenter?
    
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier{
        case "TodoAddSegue":
            if let todoAddViewController = segue.destination as? TodoAddViewController{
                self.lastViewController = self.currentViewController
                self.currentViewController = todoAddViewController
                self.presenter?.viewController = todoAddViewController
            }
        case "TodoDetailViewController":
            if let todoDetailViewController = segue.destination as? TodoDetailViewController{
                self.lastViewController = self.currentViewController
                self.currentViewController = todoDetailViewController
                self.presenter?.viewController = todoDetailViewController
            }
        default:
            print("invalid segue")
        }
    }
    
    func showAddTodo(){
        self.performSegue(withIdentifier: "TodoAddSegue", sender: self)
    }
    func showDetailTodo(){
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: self)
    }
    
}

class TodoSecondaryRouter: UIViewController, TodoRouter {
    weak var presenter: TodoPresenter?
    weak var lastViewController: UIViewController?
    weak var currentViewController: UIViewController?
}

///
///este protocolo nos va indicar donde esta la navegacion en la que estaba y actual
///
protocol TodoRouter {
    var presenter: TodoPresenter? {get set}
    var lastViewController: UIViewController? {get set}
    var currentViewController: UIViewController? {get set}
}

protocol TodoViewController {
    var presenter: TodoPresenter?{
        get set
    }
    var router: TodoRouter?{
        get set
    }
}


class TodoAddViewController: TodoSecondaryRouter, TodoViewController {
    var router: TodoRouter?
     
     override func viewDidLoad(){
         super.viewDidLoad()
         self.presenter?.viewController = self
         self.presenter?.router = self
         self.router = self
         self.router?.currentViewController = self
         
     }
    
}
/// las vitas derivan directamente de algun outer
class TodoHomeViewController: TodoMainRouter, TodoViewController {
   var router: TodoRouter?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.presenter = TodoPresenter()
        self.presenter?.viewController = self
        self.presenter?.router = self
        self.router = self
        self.router?.lastViewController = self
        self.router?.currentViewController = self
        
    }
    
}


class TodoDetailViewController: TodoSecondaryRouter, TodoViewController {
    var router: TodoRouter?
     
     override func viewDidLoad(){
         super.viewDidLoad()
         self.presenter?.viewController = self
         self.presenter?.router = self
         self.router = self
         self.router?.currentViewController = self
         
     }
}
