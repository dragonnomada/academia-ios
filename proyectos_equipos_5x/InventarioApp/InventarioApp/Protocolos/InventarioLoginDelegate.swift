//
//  InventarioLoginDelegate.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import Foundation

protocol InventarioLoginDelegate {
    
    func login(usuarioIniciado: UsuarioEntity)
    
    func loginError(loginError error: String)
    
}

protocol InventarioHomeDelegate {
    
    func inventario(productos:[(producto: ProductoEntity, transacciones: [TransaccionEntity])])
    
    func inventario(inventarioError error: String)
    
    func inventario(productoSeleccionado producto: ProductoEntity)
    
}

protocol InventarioAddProductDelegate {
    func inventario(productAdded producto: ProductoEntity)
    func inventario(addProductError error: String)
}

protocol InventarioDetailsDelegate {
    func inventario (productoSelected producto: ProductoEntity, transacciones: [TransaccionEntity])
    func inventario(filterTransactionsError error: String)
    func inventario(selectProductError error: String)
}

protocol InventarioEditProductDelegate {
    func inventario(productLoaded: ProductoEntity)
    func inventario(productEditted: ProductoEntity)
    func inventario(editError: String)
}

protocol InventarioAddEntradaDelegate {
    func inventario(transaccionCreada transaccion: TransaccionEntity)
    func inventario(productSelected product: ProductoEntity)
    func inventario(addTransaccionError error: String)
}
