//
//  inventarioModel.swift
//  InventarioApp
//
//  Created by MacBook  on 03/01/23.
//

import Foundation
import CoreData

class InventModel {
    
    let persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ModelUsuario")
        container.loadPersistentStores { _, error in
            if let error = error{
                fatalError("no existe el contenedor \(error)")
            }
        }
        return container
    }()
    
    
    var productos: [ProductoEntity] = []
    var transsaciones: [TransaccionEntity] = []
    var usuarios: [UsuarioEntity] = []
    
    func loadProductos() {
        let context = self.persistentContainer.viewContext
        let requestProductoEntity = ProductoEntity.fetchRequest()
        if let productoEntity = try? context.fetch(requestProductoEntity){
            self.productos = productoEntity
        }
    }
    
    func loadTransacciones(){
        let context = self.persistentContainer.viewContext
        let requestTransaccionEntity = TransaccionEntity.fetchRequest()
        if let transaccionEntity = try? context.fetch(requestTransaccionEntity){
            self.transsaciones = transaccionEntity
        }
    }
    
    func loadUsuarios(){
        let context = self.persistentContainer.viewContext
        let requestUsuarioEntity = UsuarioEntity.fetchRequest()
        if let usuarioEntity = try? context.fetch(requestUsuarioEntity){
            self.usuarios = usuarioEntity
        }
    }
    
    func getProducto(index: Int) -> ProductoEntity? {
        guard index >= 0 && index < productos.count else {
            return nil
        }
        return self.productos[index]
    }

    
    func getTranssacion(index: Int) -> TransaccionEntity? {
        guard index >= 0 && index < transsaciones.count else {
            return nil
        }
        return self.transsaciones[index]
    }
    
    
    func getUsuario(index: Int) -> UsuarioEntity? {
        guard index >= 0 && index < usuarios.count else {
            return nil
        }
        return self.usuarios[index]
    }


    
    
}
