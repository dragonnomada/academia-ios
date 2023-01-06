//
//  File.swift
//  InventarioApp
//
//  Created by Alan Badillo Salas on 04/01/23.
//

import Foundation

class InventarioController {
    
    static let shared = InventarioController()

    let model = InventModel()

    var inventarioLoginDelegate: InventarioLoginDelegate?
    var inventarioHomeDelegate: InventarioHomeDelegate?
    var inventarioAddProductDelegate: InventarioAddProductDelegate?
    var inventarioDetailsDelegate: InventarioDetailsDelegate?
    var inventarioEditProductDelegate: InventarioEditProductDelegate?
    var inventarioAddEntradaDelegate: InventarioAddEntradaDelegate?

    func getUsuario(nombre: String, password: String) {

        guard self.model.loadUsuarios() else {
            inventarioLoginDelegate?.loginError(loginError: "No se pueden cargar los usuarios")
            return
        }

        for usuario in self.model.usuarios {

            if usuario.nombre == nombre && usuario.password == password {
                self.model.usuarioIniciado = usuario
                inventarioLoginDelegate?.login(usuarioIniciado: usuario)
                return
            }

        }

        inventarioLoginDelegate?.loginError(loginError: "Credenciales no válidas para el usuario \(nombre)")

    }
    
    /// HomeView
    func getAllproducts() {
        self.model.loadProductos()
        self.model.loadTransacciones()

        var productos: [(producto: ProductoEntity, transacciones: [TransaccionEntity])] = []

        for producto in self.model.productos {
            print("⦿ producto \(producto)")
            print("⦿ transacciones: \(self.model.transacciones)")
            let transacciones = self.model.transacciones.filter {
                transaccion in
                transaccion.producto == producto
            }.reversed().map { reversed in
                reversed
            }
            print("⦿ transacciones filtradas: \(transacciones)")
            productos.append((
                producto: producto,
                transacciones: transacciones
            ))
        }

        if productos.count == 0 {
            self.inventarioHomeDelegate?.inventario(inventarioError: "No hay productos")
        } else {
            self.inventarioHomeDelegate?.inventario(productos: productos)
        }
    }

    func selectProducto(index: Int) {
        guard index >= 0 && index < self.model.productos.count else {
            self.inventarioHomeDelegate?.inventario(inventarioError: "Error al seleccionar el producto")
            return
        }

        self.model.productoSeleccionado = self.model.productos[index]

        self.inventarioHomeDelegate?.inventario(productoSeleccionado: self.model.productos[index])
    }
    
    /// AddProductView
    func addProduct(nombre: String, imagen: Data, descripcion: String) {
        guard let producto = self.model.addProducto(existencias: 0, image: imagen, nombre: nombre, descripcion: descripcion) else {
            inventarioAddProductDelegate?.inventario(addProductError: "Error al crear el producto \(nombre)")
            return
        }

        inventarioAddProductDelegate?.inventario(productAdded: producto)
    }
    
    /// DetailsProductView
    func getSelectedProduct() {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioDetailsDelegate?.inventario(selectProductError: "No hay producto seleccionado")
            return
        }

        self.filterSelectedProductTransactions()

        inventarioDetailsDelegate?.inventario(productoSelected: productoSeleccionado, transacciones: self.model.transaccionesProductoSeleccionado)
        inventarioEditProductDelegate?.inventario(productLoaded: productoSeleccionado)
    }

    func filterSelectedProductTransactions() {
        print("Filtrando las transacciones del producto \(self.model.productoSeleccionado?.id ?? Int64(-1))")
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioDetailsDelegate?.inventario(selectProductError: "No hay producto seleccionado")
            return
        }

        self.model.transaccionesProductoSeleccionado = self.model.transacciones.filter {
            transaccion in
            transaccion.producto == productoSeleccionado
        }

        if self.model.transaccionesProductoSeleccionado.count == 0 {
            inventarioDetailsDelegate?.inventario(filterTransactionsError: "No hay transacciones para el producto seleccionado")
        }
    }
    
    /// EditProductView
    func editProduct(nombre: String?, imagen: Data?, descripcion: String?) {
        print("Recibiendo nuevos datos para editar")
        
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioEditProductDelegate?.inventario(editError: "No hay producto seleccionado para editarse")
            return
        }
        
        print("Editando producto \(productoSeleccionado.id)")

        if let producto = self.model.updateProducto(id: productoSeleccionado.id, existencias: productoSeleccionado.existencias, imagen: imagen, nombre: nombre, descripcion: descripcion) {
            
            print("Producto editado \(productoSeleccionado.id)")
            
            self.inventarioEditProductDelegate?.inventario(productEditted: producto)
            
        }
    }
    
    /// AddTransaction
    func addSelectedProductTransaccion(entrada: Bool, unidades: Int) {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioAddEntradaDelegate?.inventario(addTransaccionError: "No hay producto seleccionado para editarse")
            return
        }

        guard unidades > 0 else {
            inventarioAddEntradaDelegate?.inventario(addTransaccionError: "Las unidades no pueden ser negativas")
            return
        }

        var balance: Int64 = 0
        
        if entrada {
            balance = productoSeleccionado.existencias + Int64(unidades)
        } else {
           balance = productoSeleccionado.existencias - Int64(unidades)
            
            guard balance >= 0 else {
                inventarioAddEntradaDelegate?.inventario(addTransaccionError: "No se pueden retirar más de las unidades disponibles")
                return
            }
        }
        
        guard let transaccion = self.model.addTransaccion(productoId: productoSeleccionado.id, balance: Int64(balance), entrada: entrada, unidades: Int64(unidades)) else {
            inventarioAddEntradaDelegate?.inventario(addTransaccionError: "No se pudo crear la transacción")
            return
        }
        
        // TODO: Notificar que la transacción fue creada
        inventarioAddEntradaDelegate?.inventario(transaccionCreada: transaccion)
        
        if let producto = self.model.updateProducto(id: productoSeleccionado.id, existencias: balance, imagen: nil, nombre: nil, descripcion: nil) {
            
            // TODO: Notificar que el producto fue actualizado
            self.filterSelectedProductTransactions()
            inventarioDetailsDelegate?.inventario(productoSelected: producto, transacciones: self.model.transaccionesProductoSeleccionado)
            //self.getAllproducts()
            
        }
    }

}
