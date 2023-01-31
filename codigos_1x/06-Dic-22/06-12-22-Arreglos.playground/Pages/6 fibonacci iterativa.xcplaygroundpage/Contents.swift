//: [Previous](@previous)

import Foundation

let n: Int = 10
var arreglo = [Int64]()

for i in 0...n {
    if i >= 2 {
        arreglo.append(Int64(arreglo[i-1]+arreglo[i-2]))
    } else{
        arreglo.append(Int64(i))
    }
}

print(arreglo)


//: [Next](@next)
