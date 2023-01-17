//
//  FrutasService.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import Combine

enum FrutasAddError: Error {
    
    case nombreVacio
    case cantidadNegativa
    
}

enum FrutaSeleccionadaError: Error {
    
    case indexFueraRango
    
}

enum FrutaEditadaError: Error {
    
    case sinFrutaSeleccionada
    case sinFrutaSeleccinadaIndex
    case sinModificaciones
    
}

enum FrutaEliminadaError: Error {
    
    case sinFrutaSeleccinadaIndex
    case indexFueraRango
    case customError(String)
    
}

class FrutasService {
    
    // State: Variables para retener informacion desde nuestro CoreData,
    
    private var frutas: [FrutaEntity] = []
    private var frutaSeleccionada: FrutaEntity?
    private var frutaSeleccionadaIndex: Int?
    
    // Notifiers: Quienes avisaran al interactor que alguna variable ha sido actualizada o modificada
    
    var frutasListSubject = PassthroughSubject<[FrutaEntity], Never>()
    var frutasAddSubject = PassthroughSubject<FrutaEntity, FrutasAddError>()
    var frutaSeleccinadaSubject = PassthroughSubject<(index: Int, fruta: FrutaEntity), FrutaSeleccionadaError>()
    var frutaEditadaSubject = PassthroughSubject<FrutaEntity, FrutaEditadaError>()
    var frutaEliminadaSubject = PassthroughSubject<(index: Int, fruta: FrutaEntity), FrutaEliminadaError>()
    
    // Funtionalities
    
    func cargarDatosPrueba() {
        
        frutas.append(FrutaEntity(nombre: "Manzana", cantidad: 13.5))
        frutas.append(FrutaEntity(nombre: "Mango", cantidad: 17.5))
        frutas.append(FrutaEntity(nombre: "Mandarina", cantidad: 4.5))
        frutas.append(FrutaEntity(nombre: "Maracuya", cantidad: 23.5))
        
    }
    
    // Transactions: Operaciones que realizara el servicio con el coredata, api, o donde quiera que se almacene nuestros datos.
    
    
    // Actualizamos frutasListSubject cuando se agregue una nueva fruta o se actualice una fruta
    func recargarFrutas() {
        
        self.frutasListSubject.send(self.frutas)
        
    }
    
    // Cuando modifiquemos la fruta seleccionada, la actualiza
    func recargarFrutaSeleccionada() {
        
        guard let frutaSeleccionadaIndex = self.frutaSeleccionadaIndex else {
            return
        }
        
        guard let frutaSeleccionada = self.frutaSeleccionada else {
            return
        }
        
        self.frutaSeleccinadaSubject.send((frutaSeleccionadaIndex, frutaSeleccionada))
        
    }
    
    // Agrega una fruta y posterior a ello actualiza el arreglo de frutas
    func agregarFruta(nombre: String, cantidad: Double, imagen: Data?) {
        
        guard !nombre.isEmpty else {
            self.frutasAddSubject.send(completion: .failure(.nombreVacio))
            return
        }
        
        guard cantidad > 0 else {
            self.frutasAddSubject.send(completion: .failure(.cantidadNegativa))
            return
        }
        
        let fruta = FrutaEntity(nombre: nombre, cantidad: cantidad, imagen: imagen)
        
        frutas.append(fruta)
        
        self.frutasAddSubject.send(fruta)
        
        self.recargarFrutas()
        
    }
    
    // Seleccionar una fruta deseada
    func seleccionarFruta(index: Int) {
        
        guard index >= 0 && index < self.frutas.count else {
            self.frutaSeleccinadaSubject.send(completion: .failure(.indexFueraRango))
            return
        }
        
        let fruta = self.frutas[index]
        
        self.frutaSeleccionada = fruta
        self.frutaSeleccionadaIndex = index
        
        self.frutaSeleccinadaSubject.send((index, fruta))
        
    }
    
    // Despues de seleccionar una fruta, procedemos a modificarla
    func editarFrutaSeleccionada(nombre: String?, cantidad: Double?, imagen: Data?) {
        
        guard let frutaSeleccionada = frutaSeleccionada else {
            self.frutaEditadaSubject.send(completion: .failure(.sinFrutaSeleccionada))
            return
        }
        
        guard let frutaSeleccionadaIndex = frutaSeleccionadaIndex else {
            self.frutaEditadaSubject.send(completion: .failure(.sinFrutaSeleccinadaIndex))
            return
        }
        
        var frutaModificada = frutaSeleccionada
        
        var sinModificaciones = true
        
        if let nombre = nombre {
            frutaModificada.nombre = nombre
            sinModificaciones = false
        }
        
        if let cantidad = cantidad {
            frutaModificada.cantidad = cantidad
            sinModificaciones = false
        }
        
        if let imagen = imagen {
            frutaModificada.imagen = imagen
            sinModificaciones = false
        }

        guard !sinModificaciones else {
            self.frutaEditadaSubject.send(completion: .failure(.sinModificaciones))
            return
        }
            
        self.frutas[frutaSeleccionadaIndex] = frutaModificada

        self.frutaEditadaSubject.send(frutaModificada)
        
        self.recargarFrutas()
        
    }
    
    // Eliminar alguna fruta 
    func eliminarFrutaSeleccionada() {
        
        guard let frutaSeleccionadaIndex = frutaSeleccionadaIndex else {
            self.frutaEliminadaSubject.send(completion: .failure(.sinFrutaSeleccinadaIndex))
            return
        }
        
        guard frutaSeleccionadaIndex >= 0 && frutaSeleccionadaIndex < self.frutas.count else {
            self.frutaEliminadaSubject.send(completion: .failure(.indexFueraRango))
            return
        }
        
        let fruta = self.frutas[frutaSeleccionadaIndex]
        
        self.frutas.remove(at: frutaSeleccionadaIndex)
        
        frutaEliminadaSubject.send((frutaSeleccionadaIndex, fruta))
        
        self.recargarFrutas()
        
    }
    
}
