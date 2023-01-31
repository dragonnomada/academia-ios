//
//  TodoHomeViewController.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import UIKit

public class TodoHomeViewController: UIViewController {

    weak var presenter: TodoHomePresenter?
    
    var todos: [TodoEntity] = []
    
    @IBOutlet weak var todosTableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        todosTableView.dataSource = self
        todosTableView.delegate = self
        
        print("Se cargó el TodoHomeViewController")
        
        self.presenter?.requestTodos()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addAction))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.closeAction))
        
    }
    
    @objc func addAction() {
        
        print("Abriendo la pantalla de TodoAdd")
        
        self.presenter?.openTodoAdd()
        
    }
    
    @objc func closeAction() {
        
        print("Abriendo la pantalla de TodoAdd")
        
        self.presenter?.closeAll()
        
    }

}

extension TodoHomeViewController: TodoHomeViewDelegate {
    
    func todos(_ todos: [TodoEntity]) {
        
        self.todos = todos
        
        self.todosTableView.reloadData()
        
    }
    
}

extension TodoHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Todos Unchecked" : "Todos Checked"
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let todosChecked = self.todos.filter({ $0.checked })
        let todosUnchecked = self.todos.filter({ !$0.checked })
        
        return section == 0 ? todosUnchecked.count : todosChecked.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let todosChecked = self.todos.filter({ $0.checked })
        let todosUnchecked = self.todos.filter({ !$0.checked })
        
        let todos = indexPath.section == 0 ? todosUnchecked : todosChecked
        
        let todo = todos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = todo.title
        
        var details = ""
        
        if let updatedAt = todo.updatedAt {
            details = "/ Actualizado: [\(updatedAt)]"
        }
        
        config.secondaryText = "Creado: \(todo.createdAt)\(details)"
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}
