//
//  LoginPasswordViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class LoginPasswordViewController: UIViewController {

    weak var presenter: LoginPasswordPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func loginAction(_ sender: Any) {
        self.presenter?.gotoHome()
    }
    
    
    @IBAction func forgetMeAction(_ sender: Any) {
        self.presenter?.gotoDefaultLogin()
    }
    
}

extension LoginPasswordViewController: LoginPasswordView {
    
}
