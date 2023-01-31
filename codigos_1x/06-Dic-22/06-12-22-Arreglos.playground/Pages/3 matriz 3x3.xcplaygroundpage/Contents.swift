//: [Previous](@previous)

import Foundation

var arreglo = [[[Int]]](repeating: [Int](repeating:0, count: 5), count: 5)
var cadena = ""
for indice in arreglo{
    cadena = ""
    for valor in indice {
        cadena += "\(valor)"
    }
    print(cadena)
}



//: [Next](@next)
