//
//  LoginPresenter.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation
import Combine

///
/// Los presentadores representan todas las operaciones que se pueden hacer con la vista y hacia la vista.
///
/// Esta inicializa y deinicializa un ViewController asociado, es decir, lo administra al 100%.
///
class LoginPresenter {
    
    // Router
    
    /// Referencia al Router para navegar a otras pantallas
    weak var router: LoginRouter?
    
    // Interactor
    
    /// Referencia al Interactor para consumir servicios
    weak var interactor: LoginInteractor?
    
    // View
    
    /// Protocolo para enviarle datos a la vista
    var view: LoginView?
    
    // Subscribers
    
    var userSignInSubscriber: AnyCancellable?
    
    // Open (Connect / Load / Initialize)
    
    func open(router: LoginRouter, interactor: LoginInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = LoginViewController()
        
        self.view?.presenter = self
        self.view?.login(willOpen: true)
        
        self.userSignInSubscriber = interactor.userSignInSubject.sink(receiveValue: {
            
            [weak self] userLogged in
            
            DispatchQueue.main.async {
                
                [weak self] in
                
                self?.view?.login(userSignIn: userLogged)
                
            }
            
        })
        
    }
    
    // Close (Disconnect / Unload / Deinitialize)
    
    func close() {
        
        self.userSignInSubscriber?.cancel()
        self.userSignInSubscriber = nil
        
        self.view?.login(willClose: true)
        
        self.view = nil
        
        self.router = nil
        self.interactor = nil
        
    }
    
    // Operations (From Views)
    
    func signIn(username: String, password: String) async {
        
        print("Llamando al interactor signIn")
        await self.interactor?.signIn(username: username, password: password)
        
    }
    
    func goToHome() {
        
        print("Navegando a la página del Home")
        
        print("Se abrirá la página de home")
        self.router?.openHome()
        print("Se cerrará la página de login")
        self.router?.closeLogin()
        
    }
    
}
