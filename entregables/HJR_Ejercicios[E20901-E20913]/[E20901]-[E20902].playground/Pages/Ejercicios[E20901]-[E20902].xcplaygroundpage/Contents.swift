/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 14-12-22
 
 Ejercicios [E20901]-[E20902]
 */

import Foundation

struct Producto {

    let nombre: String
    var precio: Double
    var existencias: Int

    init(nombreInicial: String, precioInicial: Double, existenciasIniciales: Int) {
        self.nombre = nombreInicial
        self.precio = precioInicial
        self.existencias = existenciasIniciales
    }
/*
  [E20901*] - Agrega un método llamado func sinExistencias() -> Bool a struct Producto que devuelva si el producto tiene 0 existencias.
*/
    func tieneExistencias() -> Bool {
        return self.existencias > 0
    }

}

class Almacen {

    var productos: [Producto]
    var limite: Int

    init(limiteInicial: Int) {
        self.productos = []
        self.limite = limiteInicial
    }

    func agregarProducto(producto: Producto) -> Bool {
        if (self.productos.count < self.limite) {
            self.productos.append(producto)
            self.limite += 1
            return true
        } else {
            return false
        }
    }

  /*
  [E20902] - Agrega un método llamado func capacidadDisponible() -> Int a class Almacen que
  devuelva cuántos productos se pueden agregar antes de llegar al límite.
  */
  func capacidadDisponible () -> Int {
    let cupo = self.limite - self.productos.count
    return cupo
  }
}
