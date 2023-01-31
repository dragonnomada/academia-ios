//
//  LoginBViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class LoginBViewController: UIViewController {

    weak var presenter: LoginBPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginAction(_ sender: Any) {
        self.presenter?.gotoHome()
    }
    
    
    
    @IBAction func changeEmailAction(_ sender: Any) {
        self.presenter?.closeLoginB()
    }
    
    
}

extension LoginBViewController: LoginBView {
    
}
