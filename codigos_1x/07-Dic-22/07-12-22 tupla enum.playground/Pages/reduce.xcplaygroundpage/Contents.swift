//: [Previous](@previous)

import Foundation

let arreglo = [1,2,3,4,5,6,7,8,9,10]
let resultado = arreglo.reduce(0,{acumulativo, siguiente in
    return acumulativo + siguiente
})
print(resultado)

let arreglo2 = ["E","D","U","A","R","D","O"]

let resultado2 = arreglo2.reduce("",{ acumulativo, siguiente in
    return acumulativo + siguiente
})

print(resultado2)

//: [Next](@next)
