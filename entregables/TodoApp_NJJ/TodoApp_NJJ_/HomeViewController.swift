//
//  HomeViewController.swift
//  TodoApp_NJJ_
//
//  Created by MacBook on 26/12/22.
//

import UIKit

class HomeViewController: TodoHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let presenter = self.presenter {
            self.MyTableView.dataSource = presenter
            self.MyTableView.delegate = presenter
        }
    }
    
    @IBOutlet weak var MyTableView: UITableView!
    
    @IBAction func showAddTodoAction(_ sender: Any) {
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
