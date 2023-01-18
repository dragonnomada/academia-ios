//
//  HomeView.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation

protocol HomeView: NSObject {
    
    var presenter: HomePresenter? { get set }
    
    func home(willOpen: Bool)
    
    func home(willClose: Bool)
    
    func home(userSignIn: UserEntity)
    
    func home(userSignOut: UserEntity)
    
}

extension HomeView {
    
    func home(willOpen: Bool) {
        
    }
    
    func home(willClose: Bool) {
        
    }
    
}
