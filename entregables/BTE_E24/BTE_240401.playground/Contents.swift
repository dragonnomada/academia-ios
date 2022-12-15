import UIKit


enum errorProducto: Error {
    case productoSinExistencia
    case productoIdMayorA_100
    case productoPrecioMayorA_1_000
}

struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
}
 

func precioTotalListaProductos(productos: [Producto]) throws -> Double {
    
    var precioTotalListaProductos = 0.0
    
    for producto in productos {
        
        if producto.existencias <= 0 { throw errorProducto.productoSinExistencia }
        if producto.id > 100 { throw errorProducto.productoIdMayorA_100 }
        if producto.precio > 1000 { throw errorProducto.productoPrecioMayorA_1_000 }
        
        precioTotalListaProductos += producto.precio
    }
    
    return precioTotalListaProductos
}


var listaProductos : [Producto] = []

listaProductos.append(Producto(id: 1, nombre: "Eduardo", precio: 1000, existencias: 10))
listaProductos.append(Producto(id: 100, nombre: "Luis", precio: 10, existencias: 10))
listaProductos.append(Producto(id: 3, nombre: "Javier", precio: 50, existencias: 0))

do {
    let total = try precioTotalListaProductos(productos: listaProductos)
    print(total)
} catch errorProducto.productoSinExistencia {
    print("Producto sin existencia")
} catch errorProducto.productoIdMayorA_100 {
    print("Producto ID mayor a 100")
} catch errorProducto.productoPrecioMayorA_1_000 {
    print("Producto Precio mayor a 1,000.00")
}
