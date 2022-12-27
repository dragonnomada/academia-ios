//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by User on 26/12/22.
//

import UIKit

class HomeViewController: TodoHomeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let presenter = self.presenter {
            self.tableView.dataSource = presenter
            self.tableView.delegate = presenter
        }
    }
    
    
    @IBAction func showAddTodoAction(_ sender: Any) {
        
        self.showAddTodo()
    }
    
}
