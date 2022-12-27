import UIKit

struct Producto {
    
    let nombre: String
    var precio: Double
    var existencias: Int
    
    init(nombreInicial: String, precioInicial: Double, existenciasIniciales: Int) {
        self.nombre = nombreInicial
        self.precio = precioInicial
        self.existencias = existenciasIniciales
    }
    
    func tieneExistencias() -> Bool {
        return self.existencias > 0
    }
    
    // [E20901] Agregar el método sinExistencias() -> Bool
    func sinExistencias() -> Bool {
        return self.existencias == 0
    }
    
}

struct Jugador {

    let nombre: String
    var antigüedad: Int
    var valoracion: Double

    init(nombre: String) {
        self.nombre = nombre
        self.antigüedad = 0
        self.valoracion = 0.0
    }

    func describir() {
        print("\(self.nombre) (\(self.antigüedad) años) [\(self.valoracion)]")
    }

}

let jugador1 = Jugador(nombre: "Pepe")
var jugador2 = Jugador(nombre: "Paco")
let jugador3 = Jugador(nombre: "Luis")

var jugador4 = jugador1
let jugador5 = jugador2

jugador4.valoracion = 5.0
jugador2.antigüedad = 1

jugador1.describir() // Pepe (0 años) [0.0]
jugador2.describir() // Paco (1 años) [0.0]
jugador3.describir() // Luis (0 años) [0.0]
jugador4.describir() // Pepe (0 años) [5.0]
jugador5.describir() // Paco (0 años) [0.0]

class JugadorC {

    let nombre: String
    var antigüedad: Int
    var valoracion: Double
    
    static var refCount = 0

    init(nombre: String) {
        self.nombre = nombre
        self.antigüedad = 0
        self.valoracion = 0.0
        print("Crea JugadorC \(self.nombre) \(JugadorC.refCount)")
        JugadorC.refCount += 1
    }
    
    deinit {
        print("Elimina JugadorC \(self.nombre) \(JugadorC.refCount)")
        JugadorC.refCount -= 1
    }

    func describir() {
        print("\(self.nombre) (\(self.antigüedad) años) [\(self.valoracion)] \(self)")
    }

}

print("--------------------------")

let jugador1c = JugadorC(nombre: "Pepe")
var jugador2c : JugadorC? = JugadorC(nombre: "Paco")
let jugador3c = JugadorC(nombre: "Luis")

var jugador4c = jugador1c
var jugador5c : JugadorC? = jugador2c

jugador4c.valoracion = 5.0
jugador2c!.antigüedad = 1

jugador1c.describir() // Pepe (0 años) [5.0] (modificado a través de jugador 4)
jugador2c!.describir() // Paco (1 años) [0.0]
jugador3c.describir() // Luis (0 años) [0.0]
jugador4c.describir() // Pepe (0 años) [5.0]
jugador5c!.describir() // Paco (0 años) [0.0] (modificado a través de jugador 2)

//jugador5c = nil

jugador2c = nil

print(JugadorC.refCount)

class Robot {
    
    var x: Int = 0
    var y: Int = 0
    
    func moverNorte() {
        self.y += 1
    }
    
    func moverSur() {
        self.y -= 1
    }
    
    func moverEste() {
        self.x += 1
    }
    
    func moverOeste() {
        self.x -= 1
    }
    
}

struct Punto3D {
    var x: Int
    var y: Int
    var z: Int
}

let p1 = Punto3D(x: 0, y: 0, z: 0)
let p2 = Punto3D(x: 10, y: -5, z: 8)
let p3 = Punto3D(x: -1, y: -1, z: -1)

var puntos = [p1, p2, p3]

puntos.append(Punto3D(x: 4, y: 4, z: 4))

var X: [Int] = []

for punto in puntos {
    // print(punto.x)
    X.append(punto.x)
}

print(X)

var Y: [Int] = puntos.map({ punto -> Int in punto.y })

print(Y)

// Key-Path para la propiedad punto.z
var Z: [Int] = puntos.map(\.z)

print(Z)

extension Producto {

    var precioConIva: Double {
        get { self.precio * 1.16 }
    }

}

let prod1 = Producto(nombreInicial: "Coca Cola", precioInicial: 17.5, existenciasIniciales: 100)

print(prod1)
print(prod1.precioConIva)

let a = -123

extension Int {
    func isPositive() -> Bool {
        return self >= 0
    }
}

if a.isPositive() {
    print("\(a) es positivo")
} else {
    print("\(a) es negativo")
}

class Cliente {
    
    let id: Int
    let nombre: String
    
    init(id: Int, nombre: String) {
        self.id = id
        self.nombre = nombre
    }
    
    func describir() -> String {
        return "\(self.id) \(self.nombre)"
    }
    
}

var cliente = Cliente(id: 1, nombre: "Pepe")

print("CLIENTE: \(cliente.describir())")

func iguales<T: Comparable>(a: T, b: T) -> Bool {
    return a == b
}

print(iguales(a: 123, b: 123))
