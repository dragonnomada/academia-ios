//: [Previous](@previous)

import Foundation

var contador = 0
var memoria : [String:Int] = [:]

func fibonacci( n : Int) -> Int {
    contador += 1
    if let valor = memoria["\(n)"] {
        return valor
    }
    if n < 2{
        memoria["\(n)"] = n
        return n
    }
    else{
        let x = fibonacci(n: n-1) + fibonacci(n: n-2)
        memoria["\(n)"] = x
        return x
    }
}

fibonacci(n: 10)
print(memoria)
print("Contador: \(contador)")




//: [Next](@next)
