//
//  RegisterUserDelegate.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

protocol RegisterUserDelegate: UIViewController {
    
    var presenter: RegisterUserPresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func userAuth(userCreated userAuthCreate: UserAuthInfoEntity)
    
}

extension RegisterUserDelegate {
    
    func viewWillCreate() {}
        
    func viewDidCreate() {}
        
    func viewWillRemove() {}
    
}
