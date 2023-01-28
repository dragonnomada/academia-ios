//
//  LoginUserViewController.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class LoginUserViewController: UIViewController {

    weak var presenter: LoginUserPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
}

extension LoginUserViewController: LoginUserDelegate {
    
    
    func userLogin(userLogged: UserAuthInfoEntity) {
        print("Exito al logear al usuario")
    }

    
}
