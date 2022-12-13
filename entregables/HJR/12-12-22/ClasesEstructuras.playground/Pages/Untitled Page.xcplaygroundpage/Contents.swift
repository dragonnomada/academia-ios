import UIKit

//CLASES Y ESTRUCTURAS

/*
 - Las clases engloban funciones
 - Estructuras son de tipo valor(copia) -> objeto
 - Clases son tipo referencia(misma referencia) -> instancia
 */

//-> SINTAXIS
//Clases
//<var|let > = <Estructura>(<parametros del init>)

//Estructuras
//<var|let > = <Clase>(<parametros del init>)

//-> Ejemplos

//Estructura

struct Jugador {
    let nombre: String
    var antiguedad: Int
    var valoracion: Double
    
    init(nombre: String) {
        self.nombre = nombre
        self.antiguedad = 0
        self.valoracion = 0
    }
    
    func describir() {
        print("El jugador \(self.nombre) tiene \(self.antiguedad) practicando deporte \(self.valoracion)")
    }
}

let jugador1 = Jugador(nombre: "Heber")
var jugador2 = Jugador(nombre: "Emiliano")
let jugador3 = Jugador(nombre: "Eduardo")

var jugador4 = jugador1
let jugador5 = jugador2

jugador4.valoracion = 5.0
jugador2.antiguedad = 1

jugador1.describir()
jugador2.describir()
jugador3.describir()
jugador4.describir()
jugador5.describir()

//El jugador Heber tiene 0 practicando deporte 0.0
//El jugador Emiliano tiene 1 practicando deporte 0.0
//El jugador Eduardo tiene 0 practicando deporte 0.0
//El jugador Heber tiene 0 practicando deporte 5.0
//El jugador Emiliano tiene 0 practicando deporte 0.0



