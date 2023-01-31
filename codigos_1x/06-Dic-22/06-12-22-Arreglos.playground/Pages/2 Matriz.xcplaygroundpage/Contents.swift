//: [Previous](@previous)

import Foundation

let string = ["David","Eduardo","Batista","Trujillo"]

for _  in string.enumerated() {
//    print("\(id+1):\(nombre).")
}

//print(type(of: string.contains("Eduardo")))


var arreglo = [[Int]](repeating: [Int](repeating:0, count: 5), count: 5)
var cadena = ""
for indice in arreglo{
    cadena = ""
    for valor in indice {
        cadena += "\(valor)"
    }
    print(cadena)
}

//: [Next](@next)
