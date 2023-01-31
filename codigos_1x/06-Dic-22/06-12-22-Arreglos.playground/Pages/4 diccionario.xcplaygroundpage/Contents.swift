//: [Previous](@previous)

import Foundation

var Diccionario: [String:String] = [:]

//print(type(of: Diccionario))

Diccionario["A"] = "1"
Diccionario["B"] = "2"
Diccionario["C"] = "3"
Diccionario["D"] = "4"

print(Diccionario.keys)
Diccionario["D"] = nil
print(Diccionario.keys)


for keysS in Diccionario.keys {
    print(keysS)
}
print("-------")


for valuesS in Diccionario.values {
    print(valuesS)
}
print("-------")

for (keysS, valuesS) in Diccionario{
    print("\(keysS)\(valuesS)")
}
print("-------")


//: [Next](@next)
