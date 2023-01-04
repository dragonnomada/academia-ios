//
//  ContadorController.swift
//  5301_ContadorApp_MVC
//
//  Created by Dragon on 04/01/23.
//

import Foundation

class ContadorController {
    
    static let shared = ContadorController()
    
    private let model = ContadorModel()
    
    var homeDelegate: ContadorHomeDelegate?
    var operationsDelegate: ContadorOperationsDelegate?
    
    func actualizar() {
        self.homeDelegate?.contador(conteoUpdated: self.model.conteo)
    }
    
    func incrementar(veces: Int) {
        
        if veces > 0 {
            self.model.conteo += veces
            self.model.saveContext()
            self.operationsDelegate?.contador(conteoIncremented: self.model.conteo)
            self.actualizar()
        } else {
            self.operationsDelegate?.contador(conteoError: "No puede incrementar ese número de veces")
        }
        
    }
    
    func decrementar(veces: Int) {
        
        if veces > 0 {
            self.model.conteo -= veces
            self.model.saveContext()
            self.operationsDelegate?.contador(conteoDecremented: self.model.conteo)
            self.actualizar()
        } else {
            self.operationsDelegate?.contador(conteoError: "No puede decrementar ese número de veces")
        }
        
    }
    
    func reiniciar() {
        
        if self.model.conteo != 0 {
            let conteo = self.model.conteo
            self.model.conteo = 0
            self.model.saveContext()
            self.operationsDelegate?.contador(conteoReset: conteo)
            self.actualizar()
        } else {
            self.operationsDelegate?.contador(conteoError: "Ya está reseteado")
        }
        
    }
    
}
