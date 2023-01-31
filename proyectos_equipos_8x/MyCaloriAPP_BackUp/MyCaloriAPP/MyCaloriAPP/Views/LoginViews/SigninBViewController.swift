//
//  SigninBViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class SigninBViewController: UIViewController {

    weak var presenter: SigninBPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continueAction(_ sender: Any) {
        self.presenter?.gotoLoginPassword()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.presenter?.gotoSigninA()
    }
    
}
extension SigninBViewController: SigninBView {
    
}
