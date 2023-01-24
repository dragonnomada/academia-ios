//
//  CanastaFrutasService.swift
//  8102_Entity_To_CoreData_App
//
//  Created by MacBook  on 23/01/23.
//

import Foundation
import CoreData
import Combine

class CanastaFrutasService {
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FrutasApp")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("Error al cargar el contenedor: \(error)")
                
            }
            
        }
        
        return container
    }()
    
    let canastaCreadaSubject = PassthroughSubject<CanastaFrutaEntity, Never>()
    
    let canastaSeleccionadaSubject = PassthroughSubject<CanastaFrutaEntity, Never>()
    
    private var canastaSeleccionada: CanastaFrutaEntity?
    
    func debugCanastas() {
        
        let context = self.container.viewContext
        
        let requestCanastas = CanastaFrutaCoreDataEntity.fetchRequest()
        
        guard let canastasCoreData = try? context.fetch(requestCanastas) else {
            print("No pude recuperar las canastas del CoreData")
            return
        }
        
        for canastaCoreData in canastasCoreData {
            
            if let canasta = self.getCanasta(canastaCoreData: canastaCoreData) {
                
                print("CANSTA: [\(canasta.id)] \(canasta.nombre)")
                
                print("-----------------------------")
                
                for fruta in canasta.frutas {
                    
                    print("[\(fruta.id)] \(fruta.nombre) [Cantidad: \(fruta.cantidad) kg]")
                    
                }
                
                print("-----------------------------")
                
            }
            
        }
        
    }
    
    func crearCanasta(nombre: String) {
        
        let canasta = CanastaFrutaEntity(id: Int.random(in: 1...Int(Int32.max)), nombre: nombre, frutas: [])
        
        let _ = self.getCanasta(canasta: canasta)
        
        // TODO: Notificar que la canasta fue creada
        canastaCreadaSubject.send(canasta)
        
    }
    
    func seleccionarCanasta(id: Int) {
        
        print("Seleccionando canasta: \(id)")
        
        let context = self.container.viewContext
        
        let requestCanastas = CanastaFrutaCoreDataEntity.fetchRequest()
        
        guard let canastaEncontradaCoreData = try? context.fetch(requestCanastas).filter({ $0.id == Int32(id)}).first else {
            print("Canasta no encontrada")
            return
            
        }
        
        self.canastaSeleccionada = getCanasta(canastaCoreData: canastaEncontradaCoreData)
        
        if let canasta = self.canastaSeleccionada {
            
            self.canastaSeleccionadaSubject.send(canasta)
            
        }
        
    }
    
    func agregarFrutaCanastaSeleccionada(nombre: String, cantidad: Double) {
        
        if var canastaSeleccionada = self.canastaSeleccionada {
            
            canastaSeleccionada.frutas.append(FrutaEntity(id: Int.random(in: 1...Int(Int32.max)), nombre: nombre, cantidad: cantidad))
            
            let _ = self.getCanasta(canasta: canastaSeleccionada)
            
        }
        
    }
    
    private func getCanasta(canasta: CanastaFrutaEntity) -> CanastaFrutaCoreDataEntity? {
        
        for fruta in canasta.frutas {
            
            let _ = self.getFruta(canasta: canasta, fruta: fruta)
            
        }
        
        let context = self.container.viewContext
        
        let requestCanastas = CanastaFrutaCoreDataEntity.fetchRequest()
        
        guard let canastaEncontradaCoreData = try? context.fetch(requestCanastas).filter({ $0.id == Int32(canasta.id)}).first else {
            
            let canastaNuevaCoreData = CanastaFrutaCoreDataEntity(context: context)
            
            canastaNuevaCoreData.id = Int32(canasta.id)
            canastaNuevaCoreData.nombre = canasta.nombre
            
            do {
                try context.save()
            } catch {
                context.rollback()
                return nil
            }
            
            return canastaNuevaCoreData
            
        }
        
        return canastaEncontradaCoreData
        
    }
    
    private func getFruta(canasta: CanastaFrutaEntity, fruta: FrutaEntity) -> FrutaCoreDataEntity? {
        
        let context = self.container.viewContext
        
        let requestFrutas = FrutaCoreDataEntity.fetchRequest()
        
        guard let frutaEncontradaCoreData = try? context.fetch(requestFrutas).filter({ $0.id == Int32(fruta.id)}).first else {
            
            let frutaNuevaCoreData = FrutaCoreDataEntity(context: context)
            
            frutaNuevaCoreData.id = Int32(fruta.id)
            frutaNuevaCoreData.nombre = fruta.nombre
            frutaNuevaCoreData.cantidad = fruta.cantidad
            frutaNuevaCoreData.canasta = self.getCanasta(canasta: canasta)
            
            do {
                try context.save()
            } catch {
                context.rollback()
                return nil
            }
            
            return frutaNuevaCoreData
            
        }
        
        return frutaEncontradaCoreData
        
    }
    
    private func getCanasta(canastaCoreData: CanastaFrutaCoreDataEntity) -> CanastaFrutaEntity? {
        
        var frutas: [FrutaEntity] = []
        
        let context = self.container.viewContext
        
        let requestFrutas = FrutaCoreDataEntity.fetchRequest()
        
        if let frutasCoreData = try? context.fetch(requestFrutas).filter({ $0.canasta == canastaCoreData }) {
            
            for frutaCoreData in frutasCoreData {
                
                if let fruta = self.getFruta(canastaCoreData: canastaCoreData, frutaCoreData: frutaCoreData) {
                    
                    frutas.append(fruta)
                    
                }
                
            }
            
        }
        
        return CanastaFrutaEntity(id: Int(canastaCoreData.id), nombre: canastaCoreData.nombre ?? "SIN NOMBRE DE CANASTA", frutas: frutas)
        
    }
    
    private func getFruta(canastaCoreData: CanastaFrutaCoreDataEntity, frutaCoreData: FrutaCoreDataEntity) -> FrutaEntity? {
        
        return FrutaEntity(id: Int(frutaCoreData.id), nombre: frutaCoreData.nombre ?? "SIN NOMBRE DE FRUTA", cantidad: frutaCoreData.cantidad)
        
    }
    
    func demoFrutasCanasta(id: Int) {
        
        if let canastaCoreData = try? container.viewContext.fetch(CanastaFrutaCoreDataEntity.fetchRequest()).filter({ $0.id == Int32(id) }).first {
            
            if let frutasCoreData = try? container.viewContext.fetch(FrutaCoreDataEntity.fetchRequest()).filter({ $0.canasta == canastaCoreData }) {
                
                // Canasta & Frutas
                print("\(canastaCoreData.id) - \(canastaCoreData.nombre!)")
                
                for frutaCoreData in frutasCoreData {
                    
                    print("\(frutaCoreData.id) - \(frutaCoreData.nombre!) \(frutaCoreData.cantidad)")
                    
                }
                
            }
            
        }
        
    }
    
}
