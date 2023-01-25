//
//  LoginUserPresenter.swift
//  MyDailyDiet
//
//  Created by MacBook on 25/01/23.
//

import Foundation
import Combine

class LoginUserPresenter {
    
    private weak var router: MyDailyDietRouter?
    
    private weak var interactor: UserInteractor?
    
    var view: LoginView?
    
    var userSignInSubscriber: AnyCancellable?
    var recurrentSignInSubscriber: AnyCancellable?
    var userIsActiveSubscriber: AnyCancellable?
    
    func start(router: MyDailyDietRouter, interactor: UserInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = logInViewController()
        
        self.view?.presenter = self
        
        //self.recurrentSignInSubject
        
    }
    
    func stop() {
        
        self.recurrentSignInSubject?.cancel()
        self.recurrentSignInSubject = nil
        
        self.songSelectedSubscriber?.cancel()
        self.songSelectedSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    deinit {
        print("El presentador LoginUserPresenter ha sido liberado")
    }
    
}
