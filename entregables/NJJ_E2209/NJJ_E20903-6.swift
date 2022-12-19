/*
Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
Ejercicios E2093 al E2096
Módulo 9. Clases, estructuras y protocolos
*/

import Foundation

struct Jarra {
    var capacidadMililitros: Int = 0
    let cupoMaximoMililitros: Int 

    init(cupoMaximoMililitros: Int, capacidadMililitros: Int ){
        self.cupoMaximoMililitros = 1200

    }
   
    mutating func vaciar() {
       capacidadMililitros = 0
    }

    mutating func  llenar() {
        capacidadMililitros = 1200
    }

    func agregar() -> Int{
        return capacidadMililitros + 100
    }

    func estaVacia() -> Bool {
        if capacidadMililitros == 0 {
            return true
        }
        return false
    }
    
    mutating func estaLlena() -> Bool {
        if capacidadMililitros == cupoMaximoMililitros {
            return true
        }
        return false
    }
}

var jarra1 = Jarra(cupoMaximoMililitros: 1200 , capacidadMililitros: 200)
let jarra2 = Jarra(cupoMaximoMililitros: 8000, capacidadMililitros: 0)
let jarra3 = Jarra(cupoMaximoMililitros: 5000, capacidadMililitros: 500)

var jarra5 = jarra2
var jarra6 = jarra3

jarra6.agregar()
jarra5.llenar()

print(jarra1)
print(jarra2)
print(jarra3)
print(jarra5)
print(jarra6)

class Jarras {
    var capacidadMililitros: Int = 0
    let cupoMaximoMililitros: Int 

     init(cupoMaximoMililitros: Int, capacidadMililitros: Int ){
        self.cupoMaximoMililitros = 1200

    }
   
    func vaciar() {
       capacidadMililitros = 0
    }

    func  llenar() {
        capacidadMililitros = 1200
    }

    func agregar(capacidadMililitros: Int) -> Int{
        return capacidadMililitros + 100
    }

    func estaVacia() -> Bool {
        if capacidadMililitros == 0 {
            return true
        }
        return false
    }
    
    func estaLlena() -> Bool {
        if capacidadMililitros == cupoMaximoMililitros {
            return true
        }
        return false
    }
}
var Jarra1 = Jarras(cupoMaximoMililitros: 1000, capacidadMililitros: 200)
jarra1.agregar()
jarra1.llenar()
jarra1.vaciar()
jarra1.estaVacia()

print("Jarra 1: Capacidad Maxima: \(jarra1.cupoMaximoMililitros), con una capacida ocupada de \(jarra1.cupoMaximoMililitros)")