//
//  LoginView.swift
//  MyDailyDiet
//
//  Created by MacBook on 25/01/23.
//

import Foundation

protocol LoginView: NSObject {
    
    // Delegates (Consumers)
    var presenter: LoginUserPresenter? { get set }
    
    func user(LogInUser: UserAuthEntity)
    
}
