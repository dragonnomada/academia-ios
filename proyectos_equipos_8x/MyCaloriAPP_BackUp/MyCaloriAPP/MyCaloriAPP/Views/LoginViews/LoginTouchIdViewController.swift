//
//  LoginTouchIdViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class LoginTouchIdViewController: UIViewController {

    weak var presenter: LoginTouchIdPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginWithPasswordAction(_ sender: Any) {
        self.presenter?.gotoLoginPassword()
    }
    
    @IBAction func forgetMeAction(_ sender: Any) {
        self.presenter?.gotoDefaultLogin()
    }
    
}
extension LoginTouchIdViewController: LoginTouchIdView {
    
}
