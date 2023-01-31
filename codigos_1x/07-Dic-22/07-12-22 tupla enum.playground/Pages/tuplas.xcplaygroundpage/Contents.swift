//: [Previous](@previous)

import Foundation


let http404Error = (404, "Not Found")

print(http404Error.0)
print(http404Error.1)

let (statusCode, statusMessage) = http404Error
print("\(statusCode) : \(statusMessage)")



var http200Status = (statusCode: 200, description: "OK")

print(http200Status.statusCode)
print(http200Status.description)

http200Status.statusCode = 500
print(http200Status)

//: [Next](@next)
