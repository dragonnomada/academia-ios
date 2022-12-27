import Foundation

// Variables

// var - mutables
// let - inmutables

// SINTAXIS: Con inferencia de tipo
//           <modo> <nombre> = <valor>
// SINTAXIS: Con tipo explícito
//           <modo> <nombre> : <tipo> = <valor>

// Tipos de datos

// Int (123)
// Double (1.234)
// Float (3.14)
// Bool (true | false)
// String ("Hola mundo")

// Opcionales

// Los tipos de datos requieren un valor
// pero se pueden marcar opcionales
// para permitir contener nil

// SINTAXIS: <modo> <nombre> : <tipo>? [= foo()]

// NO ES VÁLIDO:
// let a
// let a = nil
// var a : Int = nil

// Desacomplar valores opcionales

// SINTAXIS:
// let a : Int? = ...
// if let a_ = a {
//   ...
// } else {
//   ...
// }

// Iterador

// SINTAXIS:
// for i in 0...n {
//   ...
// }
//
// for i in 0..<n {
//   ...
// }

// Arreglo

// SINTAXIS: <modo> <nombre> : [<tipo>] = [<elemento 1>, <elemento 2>, ...]

// Agregar un elemento al final:
// <arreglo>.append(<elemento>)

// Agregar un elemento en algún índice:
// <arreglo>.insert(<elemento>, at: <índice>)

// Eliminar el último elemento:
// <arreglo>.removeLast()

// Eliminar un elemento en algún índice:
// <arreglo>.remove(at: <índice>)

var frutas : [String] = []

frutas.append("manzana")
frutas.insert("pera", at: 0)

print(frutas)

frutas.remove(at: 0)

print(frutas)

frutas.removeLast()

print(frutas)

// Tupla

// SINTAXIS:
// (<tipo 1>, <tipo 2>, ...)
// (<etiqueta 1>: <tipo 1>, <etiqueta 2>: <tipo 2>, ...)

let punto : (Int, Int, Int) = (1, 2, 3)

print(punto)

print(punto.0)
print(punto.1)
print(punto.2)

let persona : (nombre: String, edad: Int) = ("Pepe", 23)

print(persona)
print(persona.edad)
print(persona.nombre)

// Funciones

// SINTAXIS:
// func <nombre>(<parámetros>) -> <tipo retorno> {
//   ...
// }
//
// <parámetros>
// <nombre>: <tipo>, [<parámetros>]
// <nombre externo> <nombre interno>: <tipo>, [<parámetros>]
// _ <nombre interno>: <tipo>, [<parámetros>]

// Se puede poner un valor por defecto en los últimos parámetros si se usa supresión o en los parámetros etiquetados.

func minMax(valores: [Int]) -> (min: Int, max: Int) {
    var minimo = Int.max
    var maximo = Int.min
    
    for valor in valores {
        if valor < minimo {
            minimo = valor
        }
        if valor > maximo {
            maximo = valor
        }
    }
    
    return (minimo, maximo)
}

print(minMax(valores: [1, 4, 3, 2, -1, 6, 9, 3]))

let result = minMax(valores: [1, 4, 3, 2, -1, 6, 9, 3])

print(result.min)
print(result.max)

func suma(_ a: Int, _ b: Int) -> Int {
    return a + b
}

print(suma(1, 3))
