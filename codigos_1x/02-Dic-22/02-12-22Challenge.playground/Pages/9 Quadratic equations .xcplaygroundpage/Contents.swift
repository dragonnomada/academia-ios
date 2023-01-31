//: [Previous](@previous)

import Foundation

let a, b, c : Double

a = 1
b = 2
c = -15

// x = (-b ± sqrt(b2 - 4⋅a⋅c)) / (2⋅a14)

let root1  = (-b + (b*b - 4*a*c).squareRoot())/(2*a)
let root2  = (-b - (b*b - 4*a*c).squareRoot())/(2*a)

print(root1 ,":",root2)

//: [Next](@next)
