//: [Previous](@previous)

import Foundation

let nombre = "Eduardo Batista"


//let letra = nombre.map(String.init)

let letra = nombre.map { element in
    return String(element)
}
print(letra)


let arreglo = [1,2,3,4,5]

let arregloTransformado = arreglo.map { element in
    return element * 100
}

print(arregloTransformado)
//: [Next](@next)
