//
//  RegisterView.swift
//  MyDailyDiet
//
//  Created by MacBook on 25/01/23.
//

import Foundation

protocol RegisterView: NSObject {
    
    // Delegates (Consumers)
    
    var presenter: RegisterUserPresenter? { get set }
    
}
