//
//  HomePresenter.swift
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
class HomePresenter {
    
    // Router
    
    /// Referencia al Router para navegar a otras pantallas
    weak var router: LoginRouter?
    
    // Interactor
    
    /// Referencia al Interactor para consumir servicios
    weak var interactor: LoginInteractor?
    
    // View
    
    /// Protocolo para enviarle datos a la vista
    var view: HomeView?
    
    // Subscribers
    
    var userSignInSubscriber: AnyCancellable?
    var userSignOutSubscriber: AnyCancellable?
    
    // Open (Connect / Load / Initialize)
    
    func open(router: LoginRouter, interactor: LoginInteractor) {
        
        print("Abriendo la vista del home desde HomePresenter")
        
        self.router = router
        self.interactor = interactor
        
        self.view = HomeViewController()
        
        self.view?.presenter = self
        
        self.userSignInSubscriber = interactor.userSignInSubject.sink(receiveValue: {
            
            [weak self] userLogged in
            
            self?.view?.home(userSignIn: userLogged)
            
        })
        
        self.userSignOutSubscriber = interactor.userSignOutSubject.sink(receiveValue: {
            
            [weak self] userLogged in
            
            self?.view?.home(userSignOut: userLogged)
            
        })
        
        self.view?.home(willOpen: true)
        
    }
    
    // Close (Disconnect / Unload / Deinitialize)
    
    func close() {
        
        self.userSignOutSubscriber?.cancel()
        self.userSignOutSubscriber = nil
        
        self.view?.home(willClose: true)
        
        self.view = nil
        
        self.router = nil
        self.interactor = nil
        
    }
    
    // Operations (From Views)
    
    func requestUserLogged() {
        
        self.interactor?.requestUserLogged()
        
    }
    
    func signOut(confirm: () -> Bool) {
        
        self.interactor?.signOut(confirm: confirm)
        
    }
    
    func goToLogin() {
        
        self.router?.openLogin()
        self.router?.closeHome()
        
    }
    
}
