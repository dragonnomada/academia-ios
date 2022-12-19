/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
 
 Creado 12 diciembre 2022
 
 Ejercicios 21
 
 */

import Foundation


//Creacion estructura Producto
struct Producto {
    //Declaracion atributos de estructura Producto
    let nombre: String
    var precio: Double
    var existencias: Int
    //Inicializacion de los atributos de mi estructura producto
    init(nombreInicial: String, precioInicial: Double, existenciasIniciales: Int) {
        self.nombre = nombreInicial
        self.precio = precioInicial
        self.existencias = existenciasIniciales
    }
    //Funcion para comprobar si tiene existencias 
    func tieneExistencias() -> Bool {
        return self.existencias > 0
    }
    //Funcion para comprobar la falta de existencias          //Ejercicio  --> [E20901]
    func sinExistencias() -> Bool{
        return self.existencias == 0
    }

}
//Clase Almacen
class Almacen {
    //Atributos Clase almacen
    var productos: [Producto]
    var limite: Int
    //Inicialización de los atributos de la clase Almacen
    init(limiteInicial: Int) {
        self.productos = []
        self.limite = limiteInicial
    }
    //Funcion Agregar productos a las existencias
    func agregarProducto(producto: Producto) -> Bool {
        if (self.productos.count < self.limite) {
            self.productos.append(producto)
            self.limite += 1
            return true
        } else {
            return false
        }
    }
    //Funcion para saber cuanto queda antes de llegar al limite [E20901]
    func limiteCapacidad(producto: Producto) -> Int {

        let itemsRestantes = limite - producto.existencias
        return itemsRestantes
    }

}
