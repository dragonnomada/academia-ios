//
//  BitacoraHomeViewModel.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import Foundation
import Combine
// MARK: BitacoraHomeViewModel
// Vista-Modelo requerido por la vista BitacoraHome

class BitacoraHomeViewModel {
    
    // Cargamos la vista y modelo desde Scene
    
    
    weak var model: BitacoraModel?
    weak var view: BitacoraHomeView?

    // Definimos los susbcriber para Model
    
    var bitacorasSubscriber: AnyCancellable?
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    init(model: BitacoraModel) {
        
        self.model = model
        
        // Enlazamos a través del subscritor a Bitacoras
        self.bitacorasSubscriber = model.$bitacoras.sink(receiveValue: { [weak self] bitacoras in
            self?.view?.bitacora(bitacoras: bitacoras)
        })
        
        // Enlazamos a través del subscritor a Seleccionada
        self.bitacoraSelectedSubscriber = model.$bitacoraSelected.sink(receiveValue: { [weak self] bitacora in
            if let bitacora = bitacora {
                self?.view?.bitacora(bitacoraSelected: bitacora)
            }
        })
        
    }
    
    // TODO: Documentación Función Cargar Bitacota
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal) {
        self.model?.addBitacora(latitude: lat, longitude: lon)
    }
    
    // TODO: Documentación Funcion Selecccionar ID
    func selectBitacora(byId id: Int) {
        self.model?.selectBitacora(byId: id)
    }
    
    func refreshBitacoras() {
        guard let model = self.model else { return }
        
        self.view?.bitacora(bitacoras: model.bitacoras)
    }
    
}
