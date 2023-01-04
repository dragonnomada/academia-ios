//
//  ContadorModel.swift
//  5301_ContadorApp_MVC
//
//  Created by Dragon on 04/01/23.
//

import Foundation
import CoreData

class ContadorModel {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContadorApp")
        
        container.loadPersistentStores {
            _, error
            in
            if let error = error {
                fatalError("Error al cargar el contenedor persistente. Error: \(error)")
            }
        }
        
        return container
    }()
    
    var conteo: Int = 0
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if let contador = try? context.fetch(ContadorEntity.fetchRequest()).first {
            
            contador.conteo = Int32(conteo)
            
        } else {
            
            let contador = ContadorEntity(context: context)
            
            contador.conteo = Int32(conteo)
            
        }
        
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }
    
    func incrementar() {
        
        self.conteo += 1
        
        self.saveContext()
        
    }
    
    func decrementar() {
        
        self.conteo -= 1
        
        self.saveContext()
        
    }
    
}
