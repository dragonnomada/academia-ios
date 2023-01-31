//: [Previous](@previous)

import Foundation

enum TiposPagos {
    case credito, efectivo, cheque
}
enum Plazo {
    case meses, contado
}
var transaccion = TiposPagos.credito
var pagos = Plazo.meses

print("\(transaccion) : \(pagos)")
//: [Next](@next)
