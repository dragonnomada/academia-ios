//
//  TodoHomeViewController.swift
//  6103_Todo_MVVM
//
//  Created by Dragon on 09/01/23.
//

import UIKit
import Combine

class TodoHomeViewController: UIViewController {

    var homeViewModel = TodoHomeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    var todosSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.todosSubscriber = homeViewModel.$todos.sink(receiveValue: {
            _ in
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeViewModel.loadTodos()
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
        return self.homeViewModel.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
        
        let todo = self.homeViewModel.todos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = todo.title
        config.secondaryText = todo.checked ? "✅" : "❌"
        
        cell.contentConfiguration = config
        
        return cell
    }
    
}

extension TodoHomeViewController: UITableViewDelegate {
    
}
