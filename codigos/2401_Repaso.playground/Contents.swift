import UIKit

class Almacen<T> {
    
    var elementos: [T] = []
    
    subscript(index: Int) -> T {
        get {
            return elementos[index]
        }
        set(elemento) {
            if index >= elementos.count {
                elementos.insert(elemento, at: elementos.count)
            } else if index < 0 {
                elementos.insert(elemento, at: 0)
            } else {
                elementos[index] = elemento
            }
        }
    }
    
}

let almacenFrutas = Almacen<String>()

almacenFrutas.elementos.append("Fresa")

almacenFrutas[1] = "Mango"

print(almacenFrutas[0])
print(almacenFrutas[1])

print("------------")

almacenFrutas[0] = "Plátano"

print(almacenFrutas[0])
print(almacenFrutas[1])

print("------------")

almacenFrutas[1_000] = "Guayaba"
almacenFrutas[-1_000] = "Kiwi"

print(almacenFrutas[0])
print(almacenFrutas[1])
print(almacenFrutas[2])
print(almacenFrutas[3])

enum TipoCanasta {
    case izquierda
    case derecha
}

class CanastaDoble {
    
    var canastaIzquierda: [Int] = []
    var canastaDerecha: [Int] = []
    
    subscript(tipoCanasta: TipoCanasta, index: Int) -> Int {
        get {
            switch tipoCanasta {
            case .izquierda: return canastaIzquierda[index]
            case .derecha: return canastaDerecha[index]
            }
        }
        set {
            switch tipoCanasta {
            case .izquierda:
                if index >= canastaIzquierda.count {
                    canastaIzquierda.insert(newValue, at: canastaIzquierda.count)
                } else if index < 0 {
                    canastaIzquierda.insert(newValue, at: 0)
                } else {
                    canastaIzquierda[index] = newValue
                }
                break
            case .derecha:
                if index >= canastaDerecha.count {
                    canastaDerecha.insert(newValue, at: canastaDerecha.count)
                } else if index < 0 {
                    canastaDerecha.insert(newValue, at: 0)
                } else {
                    canastaDerecha[index] = newValue
                }
                break
            }
        }
    }
    
}

var canasta = CanastaDoble()

canasta[.izquierda, 0] = 1
canasta[.izquierda, 1] = 2

canasta[.derecha, 0] = 100
canasta[.derecha, 1] = 200

print(canasta.canastaIzquierda)
print(canasta.canastaDerecha)
