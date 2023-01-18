//
//  FrutasAddPresenter.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

class FrutasAddPresenter {
    
    // Routers
    
    weak var router: FrutasRouter?
    
    // Interactors
    
    weak var interactor: FrutasInteractor?
    
    // View & Controller
    
    weak var view: FrutasAddView?
    
    lazy var viewController: FrutasAddViewController = {
        
        let viewController = FrutasAddViewController()
        
        self.view = viewController
        viewController.presenter = self
        
        return viewController
        
    }()
    
    // Subscribers
    
    var frutasAddSubscriber: AnyCancellable?
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: FrutasInteractor) {
        
        self.interactor = interactor
        
        self.frutasAddSubscriber = interactor.frutasAddSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] fruta in
            
            self?.view?.frutas(frutaAgregada: fruta)
            self?.router?.closeFrutasAdd()
            
        })
        
    }
    
    func disconnectInteractor() {
        
        self.frutasAddSubscriber?.cancel()
        self.frutasAddSubscriber = nil
        
        self.interactor = nil
        
    }
    
    // Functionallity
    
    func describir(_ mensaje: String) {
        print("[FrutasAddPresenter] \(mensaje)")
    }
    
    // Operations
    
    func agregarFruta(nombre: String, cantidad: Double, imagen: Data?) {
        
        self.interactor?.agregarFruta(nombre: nombre, cantidad: cantidad, imagen: imagen)
        
    }
    
    func cerrarAddFruta() {
        
        self.router?.closeFrutasAdd()
        
    }
    
}
