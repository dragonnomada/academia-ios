//
//  RegisterUserViewController.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class RegisterUserViewController: UIViewController {

    weak var presenter: RegisterUserPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    

}

extension RegisterUserViewController: RegisterUserDelegate {
    
    func userAuth(userCreated userAuthCreate: UserAuthInfoEntity) {
        print("Exito al crear al usuario")
    }
    
    
}
