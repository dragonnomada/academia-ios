//
//  inventarioModel.swift
//  InventarioApp
//
//  Created by MacBook  on 03/01/23.
//

import Foundation
import CoreData
import UIKit


///
///una clase para recuperar los datos de cora data
///
class InventModel {
    
    ///
    ///NSPersistentContainer simplifica la creación y administración de la
    ///pila de datos básicos al manejar la creación del modelo de objetos
    ///administrados. en nuestro caso para el almacenamiento los productos, transacciones y usuarios
    ///
    let persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ModelUsuario")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("no existe el contenedor \(error)")
            }
            print("data core cargado exitosamente")
        }
        
        return container
    }()
    
    ///
    ///se generan variables para rebir los datos que vienen del almacén persistente de Core Data.
    ///
    var usuarioIniciado: UsuarioEntity?
    var productoSeleccionado: ProductoEntity?
    var transaccionesProductoSeleccionado: [TransaccionEntity] = []
    var productos: [ProductoEntity] = []
    var transacciones: [TransaccionEntity] = []
    var usuarios: [UsuarioEntity] = []
    
    func installProductosPrueba() {
        if let producto1 = self.addProducto(existencias: 0, image: (UIImage(named: "gansito")?.pngData())!, nombre: "Gansito", descripcion: "Pan con chocolate") {
            self.productoSeleccionado = producto1
            let _ = self.addTransaccion(productoId: producto1.id, balance: producto1.existencias + 10, entrada: true, unidades: 10)
            let _ = self.addTransaccion(productoId: producto1.id, balance: producto1.existencias + 10 + 20, entrada: true, unidades: 20)
            let _ = self.addTransaccion(productoId: producto1.id, balance: producto1.existencias + 10 + 20 - 5, entrada: true, unidades: 5)
        }
    }
    
    ///
    ///recupera los datos  delalmacén persistente de Core Data y la almacena en la lista de productos
    ///
    func loadProductos() {
        let context = self.persistentContainer.viewContext
        let requestProductoEntity = ProductoEntity.fetchRequest()
        if let productoEntity = try? context.fetch(requestProductoEntity) {
            self.productos = productoEntity
        }
        
        if self.productos.isEmpty {
            installProductosPrueba()
        }
    }
    
    ///
    ///recupera las transacciones del almacén persistente de Core Data la alamcena en la lista de transacciones.
    ///
    func loadTransacciones() {
        let context = self.persistentContainer.viewContext
        let requestTransaccionEntity = TransaccionEntity.fetchRequest()
        if let transaccionEntity = try? context.fetch(requestTransaccionEntity) {
            self.transacciones = transaccionEntity
        }
    }

    func installUsuariosPruebas() -> Bool {
        guard let _ = self.addUsuario(nombre: "admin", password: "admin123") else { return false }
        guard let _ = self.addUsuario(nombre: "test1", password: "test1") else { return false }
        guard let _ = self.addUsuario(nombre: "test2", password: "test2") else { return false }
        guard let _ = self.addUsuario(nombre: "test3", password: "test3") else { return false }
        return true
    }
    
    ///
    ///recuepra los usuarios del almacén persistente de Core Data
    ///
    func loadUsuarios() -> Bool {
        let context = self.persistentContainer.viewContext
        let requestUsuarioEntity = UsuarioEntity.fetchRequest()
        if let usuariosEntity = try? context.fetch(requestUsuarioEntity) {
            if usuariosEntity.isEmpty {
                return self.installUsuariosPruebas()
            } else {
                self.usuarios = usuariosEntity
                return true
            }
        } else {
            return self.installUsuariosPruebas()
        }
        return false
    }
    
    ///
    ///recupera un producto de la lista de productos con un numero de id enviado
    ///
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
//        guard index >= 0 && index < transacciones.count else {
//            return nil
//        }
//        return self.transacciones[index]
//    }
    
    
//    func getUsuario(index: Int) -> UsuarioEntity? {
//        guard index >= 0 && index < usuarios.count else {
//            return nil
//        }
//        return self.usuarios[index]
//    }
    
    ///
    ///agrega un producto al almacén persistente de Core Data.
    ///
    func addProducto(existencias: Int64, image: Data, nombre: String, descripcion: String) -> ProductoEntity? {
        // recordemos que la informacion esta en el contexto, hasta que ejecutemos el metodo save del contexto
        let context = self.persistentContainer.viewContext
        let producto = ProductoEntity(context: context)
        producto.id = Int64.random(in: 1...1_000_000)
        producto.image = image
        producto.existencias = existencias
        producto.nombre = nombre
        producto.descripcion = descripcion
        do {
            try context.save()
            self.loadProductos()
            return producto
        } catch {
            context.rollback()
            return nil
        }
    }
    
    ///
    ///agrega una transaccion al almacén persistente de Core Data
    ///
    func addTransaccion(productoId: Int64, balance: Int64, entrada: Bool, unidades: Int64) -> TransaccionEntity? {
        
        if let producto = self.getProducto(id: productoId) {
            let context = self.persistentContainer.viewContext
            let transaccion = TransaccionEntity(context: context)
            transaccion.balance = balance
            transaccion.entrada = entrada
            transaccion.unidades = unidades
            transaccion.producto = producto
            
            do {
                try context.save()
                self.loadTransacciones()
                return transaccion
            }catch {
                context.rollback()
                return nil
            }
        } else {
            return nil
        }
    }
    
    ///
    ///agrega un usuario al almacén persistente de Core Data
    ///
    func addUsuario(nombre: String, password: String) -> UsuarioEntity? {
        let context = self.persistentContainer.viewContext
        let usuario = UsuarioEntity(context: context)
        
        usuario.nombre = nombre
        usuario.password = password
        
        do {
            try context.save()
            let _ = self.loadUsuarios()
            return usuario
        } catch {
            context.rollback()
            return nil
        }
    }
    
    ///
    ///agrega un producto al almacén persistente de Core Data
    ///
    func updateProducto(id: Int64, existencias: Int64?, imagen: Data?, nombre: String?, descripcion: String?) -> ProductoEntity? {
        if let producto = getProducto(id: id) {
            if let existencias = existencias {
                producto.existencias = existencias
            }
            if let imagen = imagen {
                producto.image = imagen
            }
            if let name = nombre {
                producto.nombre = name
            }
            if let descripcion = descripcion {
                producto.descripcion = descripcion
            }
            let context = persistentContainer.viewContext
            do {
                try context.save()
                self.loadProductos()
                return producto
            } catch {
                context.rollback()
                return nil
            }
        }
        return nil
    }
}
