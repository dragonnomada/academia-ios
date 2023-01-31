//: [Previous](@previous)

import Foundation

//var columnas = 2
var renglones = [1, 2, 3, 4, 5, 6, 7, 8]

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
