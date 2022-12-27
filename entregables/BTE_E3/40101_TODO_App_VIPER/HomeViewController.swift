//
//  HomeViewController.swift
//  40101_TODO_App_VIPER
//
//  Created by MacBook Pro on 26/12/22.
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
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTodoAction(_ sender: Any) {
        self.showAddTodo()
    }
}
