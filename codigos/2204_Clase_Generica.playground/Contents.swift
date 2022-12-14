import UIKit

class Almacen<T> {

    var elementos: [T] = []
    var entradas: Int = 0
    var salidas: Int = 0
    
    var describe: String {
        get { "[Entradas: \(entradas) Salidas: \(salidas)] \(elementos)" }
    }

    func ingresar(_ elemento: T) {
        elementos.append(elemento)
        entradas += 1
    }
    
    func retirarTodos(condicion: (T) -> Bool) {
        elementos.removeAll { elemento in
            if condicion(elemento) {
                salidas += 1
                return true
            }
            return false
        }
    }

}

var almacen1 = Almacen<String>()

almacen1.ingresar("Manzana")
almacen1.ingresar("Pera")
almacen1.ingresar("Kiwi")
almacen1.ingresar("Plátano")

almacen1.retirarTodos(condicion: { fruta in fruta == "Pera" || fruta == "Kiwi" })

print(almacen1.describe)

struct Producto {
    
    let id: Int
    let nombre: String
    var precio: Double
    
}

var almacenProductos = Almacen<Producto>()

almacenProductos.ingresar(Producto(id: 1, nombre: "Coca", precio: 17.5))
almacenProductos.ingresar(Producto(id: 2, nombre: "Galletas Marías", precio: 15.5))
almacenProductos.ingresar(Producto(id: 3, nombre: "Gansito", precio: 23.0))
almacenProductos.ingresar(Producto(id: 4, nombre: "Corona", precio: 13.5))

almacenProductos.retirarTodos { producto in producto.id == 3 }

print(almacenProductos.describe)

extension Almacen where T == Producto {
    
    var total: Double {
        get {
            var total = 0.0
            for producto in elementos {
                total += producto.precio
            }
            return total
        }
    }
    
}

//print(almacen1.total)
print(almacenProductos.total)
