//: [Previous](@previous)

import Foundation

var columnas = 2
var renglones = [5, 3, 7, 1, 2, 4, 8, 1]

let alturaMaxima = renglones.max()!
var linea = ""

//print(alturaMaxima)
for i in stride(from: alturaMaxima, through: 0, by: -1){
    for j in stride(from: 0 , to: renglones.count, by: 1){
        if renglones[j] == i {
            linea += " *** "
        }
        if renglones[j] > i {
            linea += " * * "
        }
        if renglones[j] < i {
            linea += "     "
        }
    }
    print(linea)
    linea = ""
}

//: [Next](@next)
