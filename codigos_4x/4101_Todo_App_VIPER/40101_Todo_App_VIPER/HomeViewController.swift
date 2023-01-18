//
//  HomeViewController.swift
//  40101_Todo_App_VIPER
//
//  Created by Dragon on 26/12/22.
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func showAddTodoAction(_ sender: Any) {
        //(self.presenter?.router as! TodoMainRouter).showAddTodo()
        self.showAddTodo()
    }
}
