//
//  FrutasHomePresenter.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

class FrutasHomePresenter {
    
    // Routers
    
    weak var router: FrutasRouter?
    
    // Interactors
    
    weak var interactor: FrutasInteractor?
    
    // View & ViewController
    
    weak var view: FrutasHomeView?
    
    lazy var viewController: FrutasHomeViewController = {
        let viewController = FrutasHomeViewController()
        
        // TODO: Configuar el viewController
        viewController.presenter = self
        
        self.view = viewController
        
        return viewController
    }()
    
    // Subscribers
    
    var frutasListSubscriber: AnyCancellable?
    var frutaSeleccionadaSubscriber: AnyCancellable?
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: FrutasInteractor) {
        self.interactor = interactor
        
        self.frutasListSubscriber = interactor.frutasListSubject.sink(receiveValue: {
            
            [weak self] frutas in
            
            self?.view?.frutas(frutasCargadas: frutas)
            
        })
        
        /*self.frutaSeleccionadaSubscriber = interactor.frutaSeleccinadaSubject.sink(receiveCompletion: {
            
            [weak self] error in
            
            self?.describir("Error: \(error)")
            
        }, receiveValue: {
            
            [weak self] (index: Int, fruta: FrutaEntity) in
            
            // TODO: Navegar mediante el router hacia FrutasDetails
            //self?.describir("Navegando a FrutasDetails")
            //self?.router?.openFrutasDetails()
            
        })*/
    }
    
    func disconnectInteractor() {
        
        self.frutasListSubscriber?.cancel()
        self.frutasListSubscriber = nil
        
        self.frutaSeleccionadaSubscriber?.cancel()
        self.frutaSeleccionadaSubscriber = nil
        
        self.interactor = nil
        
    }
    
    // Functionallity
    
    func describir(_ mensaje: String) {
        print("[FrutasHomePresenter] \(mensaje)")
    }
    
    // Operations
    
    func recargarFrutas() {
        
        self.interactor?.recargarFrutas()
        
    }
    
    func seleccionarFruta(index: Int) {
        
        self.interactor?.seleccionarFruta(index: index)
        
    }
    
    func irAgregarFruta() {
        
        self.router?.openFrutasAdd()
        
    }
    
    func irDetallesFruta() {
        
        self.router?.openFrutasDetails()
        
    }
    
}
