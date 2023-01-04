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
            print("data core cargado exitosamente")
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
    
    func getProducto(id: Int64) -> ProductoEntity? {
        var resultado: ProductoEntity?

        for producto in productos {
            if producto.id == id {
                resultado = producto
            }
        }

        return resultado
    }

    
//    func getTranssacion(index: Int) -> TransaccionEntity? {
//        guard index >= 0 && index < transsaciones.count else {
//            return nil
//        }
//        return self.transsaciones[index]
//    }
    
    
//    func getUsuario(index: Int) -> UsuarioEntity? {
//        guard index >= 0 && index < usuarios.count else {
//            return nil
//        }
//        return self.usuarios[index]
//    }

    
    
    func addProducto(existencias: Int64, image: Data, nombre: String, precio: Double) -> ProductoEntity? {
        // recordemos que la informacion esta en el contexto, hasta que ejecutemos el metodo save del contexto
        let context = self.persistentContainer.viewContext
        let producto = ProductoEntity(context: context)
        
        producto.id = Int64.random(in: 1...1_000_000)
        producto.image = image
        producto.existencias = existencias
        producto.nombre = nombre
        producto.precio = precio
        
        
        do{
            try context.save()
            self.loadProductos()
            return producto
        }catch{
            context.rollback()
            return nil
        }
    }
    
    func addTransaccion(productoId: Int64, balance: Int64, entrada: Bool, unidades: Int64) -> TransaccionEntity? {
        
        if let producto = self.getProducto(id: productoId) {
            let context = self.persistentContainer.viewContext
            let transaccion = TransaccionEntity(context: context)
            
            transaccion.balance = balance
            transaccion.entrada = entrada
            transaccion.unidades = unidades
            transaccion.producto = producto
            
            do{
                try context.save()
                self.loadTransacciones()
                return transaccion
            }catch{
                context.rollback()
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func addUsuario(nombre: String, password: String) -> UsuarioEntity? {
        let context = self.persistentContainer.viewContext
        let usuario = UsuarioEntity(context: context)
        
        usuario.nombre = nombre
        usuario.password = password
        
        do{
            try context.save()
            self.loadUsuarios()
            return usuario
        }catch{
            context.rollback()
            return nil
        }
    }
    
    func updateProducto(id: Int64, existencias: Int64?, imagen: Data?, nombre: String?, precio: Double?) -> ProductoEntity? {
        if let producto = getProducto(id: id){
            if let existencias = existencias{
                producto.existencias = existencias
            }
            if let imagen = imagen{
                producto.image = imagen
            }
            if let name = nombre{
                producto.nombre = name
            }
            if let precio = precio{
                producto.precio = precio
            }
        }
        return nil
    }
}
