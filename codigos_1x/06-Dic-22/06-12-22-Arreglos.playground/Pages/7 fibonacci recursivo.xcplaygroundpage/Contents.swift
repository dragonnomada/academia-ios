//: [Previous](@previous)

import Foundation

var contador = 0
var memoria : [String:Int] = [:]

func fibonacci( n : Int) -> Int {
    contador+=1
    if n < 2 {
        return n
    }
    return fibonacci(n: n-1) + fibonacci(n: n-2)
}
print(fibonacci(n: 10))
print("Contador: \(contador)")




//: [Next](@next)
