//
//  HomeViewController.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    weak var presenter: HomePresenter?
    
    @IBOutlet var todosTableView: UITableView!
    
    var todosChecked: [TodoEntity] = []
    var todosUnchecked: [TodoEntity] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Todo Home"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonAction))
        
        self.todosTableView.dataSource = self
        self.todosTableView.delegate = self
        
    }
    
    @objc func addButtonAction() {
        
        self.presenter?.goToAdd()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.requestTodos()
        
    }

}

extension HomeViewController: HomeViewDelegate {
    
    func todos(todosChecked todos: [TodoEntity]) {
        
        self.todosChecked = todos
        
        self.todosTableView.reloadData()
        
    }
    
    func todos(todosUnchecked todos: [TodoEntity]) {
        
        self.todosUnchecked = todos
        
        self.todosTableView.reloadData()
        
    }
    
    
    func todos(todoSelected todo: TodoEntity) {
        
        
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Todos Unchecked" : "Todos Checked"

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? self.todosUnchecked.count : self.todosChecked.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
        
        var config = cell.defaultContentConfiguration()
        
        let todos = indexPath.section == 0 ? self.todosUnchecked : self.todosChecked
        
        let todo = todos[indexPath.row]
        
        config.text = todo.title
        
        config.secondaryText = "\(todo.createAt ?? Date.now)"
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}
