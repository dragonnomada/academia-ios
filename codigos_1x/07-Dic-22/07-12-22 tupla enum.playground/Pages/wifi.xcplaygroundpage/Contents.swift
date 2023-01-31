//: [Previous](@previous)

import Foundation

enum SeguridadWifi {
    case wep([Int])
    case wpa(String)
    case wpa2(Double)
}
enum Conexion {
    case lan
    case wifi(SeguridadWifi)
}

var nuevaConexion = Conexion.wifi(.wpa("A0A1A2A3"))

switch nuevaConexion {
    case .lan:
        print("Conexión: LAN")
    case .wifi(let SeguridadWifi):
        switch SeguridadWifi{
            case .wep(let numeroPass):
                print("Conexión: \(numeroPass)")
            case .wpa(let cadenaPass):
                print("Conexión: \(cadenaPass)")
            case .wpa2(let doublePass):
                print("Conexión: \(doublePass)")
        }
}

//: [Next](@next)
