//: [Previous](@previous)

import Foundation

var info = ["name":"Eduardo","profession":"Desarrollador","country":"México","city":";CDMX"]


print(info)
info["country"] = "USA"
info["city"] = "Cleveland"
info["state"] = "Ohio"
print(info)

info["city"] = nil
info["state"] = nil
print("-----------------")

for (keysS, valuesS) in info{
    print("\(keysS): \(valuesS)")
}
print("-----------------")


//: [Next](@next)
