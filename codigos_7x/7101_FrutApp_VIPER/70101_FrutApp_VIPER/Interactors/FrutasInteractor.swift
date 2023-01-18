//
//  FrutasInteractor.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

class FrutasInteractor {
    
    // Service
    
    private lazy var service: FrutasService = {
        let service = FrutasService()
        
        // Inicializa el servicio
        service.cargarDatosPrueba()
        
        return service
    }()
    
    // Notificators
    
    lazy var frutasListSubject: PassthroughSubject<[FrutaEntity], Never> = {
        return self.service.frutasListSubject
    }()
    
    lazy var frutasAddSubject: PassthroughSubject<FrutaEntity, FrutasAddError> = {
        return self.service.frutasAddSubject
    }()
    
    lazy var frutaSeleccinadaSubject: PassthroughSubject<(index: Int, fruta: FrutaEntity), FrutaSeleccionadaError> = {
        return self.service.frutaSeleccinadaSubject
    }()
    
    lazy var frutaEditadaSubject: PassthroughSubject<FrutaEntity, FrutaEditadaError> = {
        return self.service.frutaEditadaSubject
    }()
    
    lazy var frutaEliminadaSubject: PassthroughSubject<(index: Int, fruta: FrutaEntity), FrutaEliminadaError> = {
        return self.service.frutaEliminadaSubject
    }()
    
    // Operations
    
    func recargarFrutaSeleccionada() {
        
        self.service.recargarFrutaSeleccionada()
        
    }
    
    func recargarFrutas() {
        
        self.service.recargarFrutas()
        
    }
    
    func agregarFruta(nombre: String, cantidad: Double, imagen: Data?) {
        
        // TODO: Si hay más de 10 frutas no dejar agregar
        
        self.service.agregarFruta(nombre: nombre, cantidad: cantidad, imagen: imagen)
        
    }
    
    func seleccionarFruta(index: Int) {
        
        self.service.seleccionarFruta(index: index)
        
    }
    
    func editarFrutaSeleccionada(nombre: String?, cantidad: Double?, imagen: Data?) {
        
        self.service.editarFrutaSeleccionada(nombre: nombre, cantidad: cantidad, imagen: imagen)
        
    }
    
    func eliminarFrutaSeleccionada(secret: String) {
        
        if secret == "12345" {
            self.service.eliminarFrutaSeleccionada()
        } else {
            self.service.frutaEliminadaSubject.send(completion: .failure(.customError("El código secreto para eliminar no es válido")))
        }
        
    }
    
}
