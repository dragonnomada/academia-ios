//
//  TodoHomeViewController.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import UIKit

class TodoHomeViewController: UIViewController {
    
    weak var presenter: TodoHomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TodoHomeViewController: TodoHomeView {
    
    func todo(todoSelected todo: TodoEntity) {
        
        
    }
}
