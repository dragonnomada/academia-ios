/*
    Joel Brayan Navor Jimenez
    [E20914] - Verifica que en la estructura producto no podamos acceder a la propiedad id desde afuera (desde el objeto).

    [E20915] - Crear una estructura llamada Jugador similar a la de ejercicios anteriores y recuperar todas las valoraciones con el key-path: \.valoracion

    [E20916] - Agregar un callAsFunction a la estructura del Jugador para devolver la antigüedad multiplicada por la valoración.

*/

import Foundation
//Creacion de la estructura Producto
struct Producto {
    private let id: Int  = 1//Propiedad id Privada

    func accedeId(id: Int) {
        print(id)
    }
}
//Imprimimos el contenido de producto
let producto1 = Producto()
print(producto1)

struct Jugador {
    var id: Int = 0
    var nombre: String = ""
    var numero: Int = 0
    var posicion: String = ""
    var valoracion: Int = 0
    var antiguedad: Int = 0

  


    init(valoracion: Int, id: Int, nombre: String, numero: Int, posicion: String, antiguedad: Int){
        self.id = id
        self.nombre = nombre
        self.numero = numero
        self.posicion = posicion
        self.valoracion = valoracion
        self.antiguedad = antiguedad
    }
    // [E20916] CallasFunction
    func callAsFunction() -> Int {
        return self.valoracion * self.antiguedad
    }

    

}

let jugadores: [Jugador] = []
let valoraciones = jugadores.map(\.valoracion)