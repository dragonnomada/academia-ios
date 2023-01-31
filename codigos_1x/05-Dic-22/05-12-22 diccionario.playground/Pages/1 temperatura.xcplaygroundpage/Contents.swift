import Foundation

let temperatura : Double = 32
let celsius = Double(temperatura - 32)/1.8
let farenheit = temperatura * 1.8 + 32

print("\(celsius) ºC")
print("\(farenheit) ºF")

if temperatura < 32 {
    print("Demasiado Frio")
} else {
    print("Temperatura mayor a 0")
}
