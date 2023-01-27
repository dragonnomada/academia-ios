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
    
    var recurrentSignInSubscriber: AnyCancellable?
    var userSignInSubscriber: AnyCancellable?
    var userIsActiveSubscriber: AnyCancellable?
    
    func start(router: MyDailyDietRouter, interactor: UserInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = LogInViewController()
        
        self.view?.presenter = self
        
        self.recurrentSignInSubscriber = interactor.recurrentSignInSubject.sink(receiveValue: {
            
            [weak self] (user, _) in
            
            if let user = user {
                
                self?.view?.user(LogInUser: user)
                
            }
        })
        
        self.userSignInSubscriber = interactor.userSignInSubject.sink(receiveValue: {
            
            [weak self] (user, _) in
            
            if let user = user {
                
                print("SESIÓN INICIADA: \(user)")
                
                self?.view?.user(LogInUser: user)
                
            }
        })
        
    }
    
    /*func signIn(router: MyDailyDietRouter, interactor: UserInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = LogInViewController()
        
        self.view?.presenter = self
        
        self.userSignInSubscriber = interactor.userSignInSubject.sink(receiveValue: {
            
            [weak self] (user, _) in
            
            if let user = user {
                
                self?.view?.user(LogInUser: user)
                
            }
        })
        
    }*/
    
    // MARK: Funciones de Login
    
    func LogInUser(email: String, password: String, active: Bool) {
        
        print("Llamando al servicio loginUser")
        self.interactor?.LogInUser(email: email, password: password, active: active)
        
    }
    
    func stop() {
        
        self.recurrentSignInSubscriber?.cancel()
        self.recurrentSignInSubscriber = nil
        self.userSignInSubscriber?.cancel()
        self.userSignInSubscriber = nil
        self.userIsActiveSubscriber?.cancel()
        self.userIsActiveSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    deinit {
        print("El presentador LoginUserPresenter ha sido liberado")
    }
    
    // Ir a pantalla de registro de usuario desde pantalla login
    func goToRegisterUser() {
        
        print("[LoginUserPresenter] Navegando a RegisterUser")
        
        print("[LoginUserPresenter] Router? \(self.router != nil ? "SI" : "NO")")
        
        self.router?.goToRegisterUser()
        
    }
    
}
