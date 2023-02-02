//
//  TodoHomeViewController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import UIKit

class TodoHomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // Variable global donde se giuardaran todos los "Todos"
    var todos: [TodoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TodoController.shared.homeDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        TodoController.shared.getTodos()
        
    }

}

extension TodoHomeViewController: TodoHomeDelegate {
    
    func todo(todosUpdated todos: [TodoEntity]) {
        self.todos = todos
        self.tableView.reloadData()
    }
    
}

extension TodoHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        
        let todo = self.todos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        if let title = todo.title {
            config.text = "\(todo.checked ? "✅" : "❌") \(title)"
        }
        
        var secondarytext = ""
        
        if let createAt = todo.createAt {
            secondarytext += createAt.toString()
        }
        
        if let updateAt = todo.updateAt {
            secondarytext += updateAt.toString()
        }
        
        config.secondaryText = secondarytext
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}

extension TodoHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = self.todos[indexPath.row]
        
        self.performSegue(withIdentifier: "TodoDetailsSegue", sender: nil)
        
        TodoController.shared.selectTodo(index: indexPath.row, todo: todo)
        
    }
    
}
