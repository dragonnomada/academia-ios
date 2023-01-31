//
//  LoginAViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class LoginAViewController: UIViewController {

    weak var presenter: LoginAPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func loginContinueAction(_ sender: Any) {
        self.presenter?.gotoLoginB()
    }
    
    
    @IBAction func signinAction(_ sender: Any) {
        self.presenter?.gotoSigninA()
    }
    

}

extension LoginAViewController: LoginAView {
    
}
