//
//  LoginUserDelegate.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

protocol LoginUserDelegate: UIViewController {
    
    var presenter: LoginUserPresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func userLogin(userLogged userLogged: UserAuthInfoEntity)
    
}

extension LoginUserDelegate {
    
    func viewWillCreate() {}
        
    func viewDidCreate() {}
        
    func viewWillRemove() {}
    
}
