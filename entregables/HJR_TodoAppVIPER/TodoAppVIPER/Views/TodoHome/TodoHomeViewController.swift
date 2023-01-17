//
//  TodoHomeViewController.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import UIKit

class TodoHomeViewController: UIViewController {

    weak var presenter: TodoHomePresenter?
    
    var todos: [TodoEntity] = []
    
    @IBOutlet weak var todosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todosTableView.dataSource = self
        self.todosTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.recargarTodos()
        
    }
    
    @IBAction func addTodoButton() {
        
        self.presenter?.goAgregarTodo()
        
    }

}

extension TodoHomeViewController: TodoHomeView {
    
    func todo(todosCargadas todos: [TodoEntity]) {
        
        self.todos = todos
        
        self.todosTableView.reloadData()
        
    }
    
    func todo(todoSeleccionado todo: TodoEntity, index: Int) {
        
        self.presenter?.goDetallesTodo()
    }
    
}

extension TodoHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Frutas"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.todos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                
        var config = cell.defaultContentConfiguration()
        
        let index = indexPath.row
        let todo = self.todos[index]
        
        config.text = todo.title
        //config.secondaryText = todo.checked
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}

extension TodoHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        self.presenter?.seleccionarTodo(index: index)
        
        self.presenter?.goDetallesTodo()
        
    }
    
}

