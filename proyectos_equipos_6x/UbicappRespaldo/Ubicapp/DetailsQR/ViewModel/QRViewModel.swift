//
//  Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 12 de enero del 2023 por jonothan Amador
// Modificaciones:
// Modificado por: Jonathan Amador el 13/01/2023
//

import Foundation
import Combine

///
///protocolo
///
///
class QRViewModel {
    
    
    ///intancia del protocolo
    ///
    var view: QRView?
    var ubicappModel: UbicappModel?
    var subscriber: AnyCancellable?
    
    
    
    init(model: UbicappModel) {
        
        self.ubicappModel = model
        
        self.subscriber = ubicappModel?.$ubicacionSeleccionada.sink{
            [weak self] ubicacionSeleccionada in
            
            self?.view?.ubicacion(ubicacionSelecionada: ubicacionSeleccionada)
        }
    }
    
    // Si se pide la última ubicación seleccionada se envia a la vista
    func requestUbicacionSeleccionada() {
        // Mandamos la última ubicación seleccionada
        // de esta manera comunicamos la ubicacion seleccinada al view controller
        self.view?.ubicacion(ubicacionSelecionada: self.ubicappModel?.ubicacionSeleccionada)
    }
    
    func actualizarUbicacion(name: String?, image: Data?) {
        self.ubicappModel?.actualizarUbicacion(nombre: name, latitud: nil, longitud: nil, imagen: image)
    }
}
