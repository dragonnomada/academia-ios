//
//  FrutasEditPresenter.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

class FrutasEditPresenter {
    
    // Routers
    
    weak var router: FrutasRouter?
    
    // Interactors
    
    weak var interactor: FrutasInteractor?
    
    // View & Controller
    
    weak var view: FrutasEditView?
    
    lazy var viewController: FrutasEditViewController = {
        
        let viewController = FrutasEditViewController()
        
        self.view = viewController
        viewController.presenter = self
        
        return viewController
        
    }()
    
    // Subscribers
    
    var frutaEditadaSubscriber: AnyCancellable?
    var frutaEliminadaSubscriber: AnyCancellable?
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: FrutasInteractor) {
        
        self.interactor = interactor
        
        self.frutaEditadaSubscriber = interactor.frutaEditadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] fruta in
            
            self?.describir("Fruta editada \(fruta)")
            self?.view?.frutas(frutaEditada: fruta)
            
        })
        
        self.frutaEliminadaSubscriber = interactor.frutaEliminadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] fruta in
            
            self?.describir("Fruta eliminada \(fruta)")
            self?.router?.closeFrutasEdit(animated: false)
            
        })
        
    }
    
    func disconnectInteractor() {
        
        self.frutaEditadaSubscriber?.cancel()
        self.frutaEditadaSubscriber = nil
        
        self.frutaEliminadaSubscriber?.cancel()
        self.frutaEliminadaSubscriber = nil
        
        self.interactor = nil
        
    }
    
    // Functionallity
    
    func describir(_ mensaje: String) {
        print("[FrutasEditPresenter] \(mensaje)")
    }
    
    // Operations
    
    func editarFrutaSeleccionada(nombre: String?, cantidad: Double?, imagen: Data?) {
        
        self.interactor?.editarFrutaSeleccionada(nombre: nombre, cantidad: cantidad, imagen: imagen)
        
    }
    
    func eliminarFrutaSeleccionada(confirmacion: Bool) {
        
        var secret = ""
        
        if confirmacion {
            secret = "12345"
        }
        
        self.interactor?.eliminarFrutaSeleccionada(secret: secret)
        
    }
    
}
