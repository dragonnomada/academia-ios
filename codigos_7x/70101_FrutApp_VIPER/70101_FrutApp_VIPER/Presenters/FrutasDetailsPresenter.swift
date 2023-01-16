//
//  FrutasDetailsPresenter.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

class FrutasDetailsPresenter {
    
    // Routers
    
    weak var router: FrutasRouter?
    
    // Interactors
    
    weak var interactor: FrutasInteractor?
    
    // View & Controller
    
    weak var view: FrutasDetailsView?
    
    lazy var viewController: FrutasDetailsViewController = {
        
        let viewController = FrutasDetailsViewController()
        
        self.view = viewController
        viewController.presenter = self
        
        return viewController
        
    }()
    
    // Subscribers
    
    var frutaSeleccionadaSubscriber: AnyCancellable?
    var frutaEditadaSubscriber: AnyCancellable?
    var frutaEliminadaSubscriber: AnyCancellable?
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: FrutasInteractor) {
        
        self.interactor = interactor
        
        self.frutaSeleccionadaSubscriber = interactor.frutaSeleccinadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] (index, fruta) in
            
            self?.describir("Fruta seleccionada \(index) \(fruta)")
            self?.describir(self?.view == nil ? "SIN VIEW" : "CON VIEW")
            self?.view?.frutas(frutaSeleccionada: fruta)
            
        })
        
        self.frutaEditadaSubscriber = interactor.frutaEditadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] fruta in
            
            self?.describir("Fruta editada \(fruta)")
            self?.view?.frutas(frutaSeleccionada: fruta)
            
        })
        
        self.frutaEliminadaSubscriber = interactor.frutaEliminadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] fruta in
            
            self?.describir("Fruta eliminada \(fruta)")
            self?.router?.closeFrutasDetails()
            
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
        print("[FrutasDetailsPresenter] \(mensaje)")
    }
    
    // Operations
    
    func reloadFrutaSeleccionada() {
        
        self.interactor?.recargarFrutaSeleccionada()
        
    }
    
    func irEditarFruta() {
        
        self.router?.openFrutasEdit()
        
    }
    
}
