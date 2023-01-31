//
//  SigninAViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class SigninAViewController: UIViewController {

    weak var presenter: SigninAPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func conitueAction(_ sender: Any) {
        self.presenter?.gotoSigninB()
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.presenter?.gotoLoginA()
    }
    
}

extension SigninAViewController: SigninAView {
    
}
