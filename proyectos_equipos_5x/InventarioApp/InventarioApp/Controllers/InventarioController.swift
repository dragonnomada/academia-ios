//
//  File.swift
//  InventarioApp
//
//  Created by Alan Badillo Salas on 04/01/23.
//

import Foundation

class InventarioController {

    let model = InventModel()

    var inventarioLoginDelegate: InventarioLoginDelegate?
    var inventarioHomeDelegate: InventarioHomeDelegate?
    var inventarioAddProductDelegate: InventarioAddProductDelegate?
    var inventarioDetailsDelegate: InventarioDetailsDelegate?
    var inventarioEditProductDelegate: InventarioEditProductDelegate?
    var inventarioAddEntradaDelegate: InventarioAddEntradaDelegate?

    func getUsuario(nombre: String, password: String) {

        guard self.model.loadUsuarios() else {
            inventarioLoginDelegate.loginError(loginError: "No se pueden cargar los usuarios")
            return
        }

        for let usuario in self.model.usuarios {

            if usuario.nombre == nombre && usuario.password == password {
                self.model.usuarioIniciado = usuario
                inventarioLoginDelegate.login(usuarioIniciado: usuario)
                return
            }

        }

        inventarioLoginDelegate.loginError(loginError: "Credenciales no válidas para el usuario \(nombre)")

    }
    
    /// HomeView
    func getAllproducts() {
        self.model.loadProductos()
        self.model.loadTransacciones()

        var productos: [(producto: ProductoEntity, transacciones: [TransaccionEntity])] = []

        for producto in self.model.productos {
            productos.append((
                producto: producto,
                transacciones: transacciones.filter {
                    transaccion in
                    transaccion.producto == producto
                }
            ))
        }

        if productos.count == 0 {
            self.inventarioHomeDelegate.inventario(inventarioError: "No hay productos")
        } else {
            self.inventarioHomeDelegate.inventario(productos: productos)
        }
    }

    func selectProducto(index: Int) {
        guard index >= 0 && index < self.model.productos.count else {
            self.inventarioHomeDelegate.inventario(inventarioError: "Error al seleccionar el producto")
            return
        }

        self.model.productoSeleccionado = self.model.productos[index]

        self.inventarioHomeDelegate.inventario(productoSeleccionado producto: self.model.productoSeleccionado)
    }
    
    /// AddProductView
    func addProduct(nombre: String, imagen: Data, precio: Double) {
        guard let producto = self.model.addProducto(existencias: 0, image: imagen, nombre: nombre, precio: precio) else {
            inventarioAddProductDelegate.inventario(addProductError: "Error al crear el producto \(nombre)")
            return
        }

        inventarioAddProductDelegate.inventario(productAdded: producto)
    }
    
    /// DetailsProductView
    func getSelectedProduct() {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioDetailsDelegate.inventario(selectProductError: "No hay producto seleccionado")
        }

        self.filterSelectedProductTransactions()

        inventarioDetailsDelegate.inventario(productoSelected: productoSeleccionado, transacciones: self.model.transaccionesProductoSeleccionado)
    }

    func filterSelectedProductTransactions() {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioDetailsDelegate.inventario(selectProductError: "No hay producto seleccionado")
        }

        self.model.transaccionesProductoSeleccionado = self.model.transacciones.filter {
            transaccion in
            transaccion.producto == productoSeleccionado
        }

        if self.model.transaccionesProductoSeleccionado.count == 0 {
            inventarioDetailsDelegate.inventario(filterTransactionsError: "No hay transacciones para el producto seleccionado")
        }
    }
    
    /// EditProductView
    func editProduct(nombre: String?, imagen: Data?, precio: Double?) {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioEditProductDelegate.inventario(editError: "No hay producto seleccionado para editarse")
            return
        }

        self.model.updateProducto(id: productoSeleccionado.id, existencias: productoSeleccionado.existencias, imagen: imagen, nombre: nombre, precio: precio)
    }
    
    /// AddTransaction
    func addSelectedProductTransaccion(entrada: Bool, unidades: Int) {
        guard let productoSeleccionado = self.model.productoSeleccionado else {
            inventarioAddEntradaDelegate.inventario(addTransaccionError: "No hay producto seleccionado para editarse")
            return
        }

        guard unidades > 0 else {
            inventarioAddEntradaDelegate.inventario(addTransaccionError: "Las unidades no pueden ser negativas")
            return
        }

        if entrada {
            let balance = productoSeleccionado.existencias + unidades
            guard let transaccion = self.model.addTransaccion(productoId: productoSeleccionado.id, balance: Int64(balance), entrada: true, unidades: unidades) else {
                inventarioAddEntradaDelegate.inventario(addTransaccionError: "No se pudo crear la transacción")
                return
            }
            self.model.updateProducto(id: productoSeleccionado.id, existencias: balance, imagen: nil, nombre: nil, precio: nil)
        } else {
            let balance = productoSeleccionado.existencias - unidades
            guard balance < 0 else {
                inventarioAddEntradaDelegate.inventario(addTransaccionError: "No se pueden retirar más unidades que las existentes")
                return
            }
            guard let transaccion = self.model.addTransaccion(productoId: productoSeleccionado.id, balance: Int64(balance), entrada: false, unidades: unidades) else {
                inventarioAddEntradaDelegate.inventario(addTransaccionError: "No se pudo crear la transacción")
                return
            }
            self.model.updateProducto(id: productoSeleccionado.id, existencias: balance, imagen: nil, nombre: nil, precio: nil)
        }
    }

}