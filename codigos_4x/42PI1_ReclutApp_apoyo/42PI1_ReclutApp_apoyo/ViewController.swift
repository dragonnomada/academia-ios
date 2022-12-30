//
//  ViewController.swift
//  42PI1_ReclutApp_apoyo
//
//  Created by Dragon on 27/12/22.
//

import UIKit
import CoreData

class Folio {
    private static var _folio: Int32 = 0
    
    static var folio: Int32 {
        _folio += 1
        return _folio
    }
}

extension Prospecto {
    
    var diasRetraso: Double {
        
        if let fechaInicio = self.fechaInicio {
            
            let diff = Date.now.timeIntervalSince1970 - fechaInicio.timeIntervalSince1970
            
            return diff.magnitude
            
        }
        
        return 0
        
    }
    
}

class ViewController: UIViewController {

    var persistentReclutAppModel: NSPersistentContainer?
    
    var prospectos: [Prospecto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = persistentReclutAppModel?.viewContext {
            
            let requestProspectos = Prospecto.fetchRequest()
            
            if let prospectos = try? context.fetch(requestProspectos) {
                self.prospectos = prospectos
                
                for prospecto in prospectos {
                    print("Prospecto: [\(prospecto.id)] \(prospecto.nombre!) ")
                    print("Días estimados: \(prospecto.diasEstimados)")
                    print("Días de retraso: \(prospecto.diasRetraso)")
                }
            }
            
            // CÓDIGO DE PRUEBA
            let prospecto1 = Prospecto(context: context)
            
            prospecto1.id = Folio.folio
            prospecto1.nombre = "Pepe Díaz"
            prospecto1.direccion = "Av. Palmas"
            prospecto1.estado = "RECLUTADO"
            prospecto1.diasEstimados = Int32(10)
            prospecto1.fechaInicio = Date.now
            
            do {
                try context.save()
            } catch {
                context.rollback()
            }
            
        }
        
    }


}

