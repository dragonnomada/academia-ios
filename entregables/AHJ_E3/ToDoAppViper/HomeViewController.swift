//
//  HomeViewController.swift
//  ToDoAppViper
//
//  Created by MacBook  on 26/12/22.
//

import UIKit

class HomeViewController: TodoHomeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presenter = presenter{
            self.tableView.dataSource = presenter
            self.tableView.delegate = presenter
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func showAddTodoAccion(_ sender: Any) {
        self.showAddTodo()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
