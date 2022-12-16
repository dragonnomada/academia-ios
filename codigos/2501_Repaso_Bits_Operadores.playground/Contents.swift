import UIKit

// Bits y Bytes

// Un bit almacena un 1 o 0

// Un byte almacena 8-bits (0b0000_0000 -> 0b1111_1111)

// Los bytes normales tienen signo, pero existen los bytes sin signo
// Con signo: El bit más a la izquierda indica el signo (0 - positivo 1 - negativo)
//            Los bits negativos se invierten (0 representa ahora al 1)
//            Para 8-bits el rango es de (-128=[1]000_0000, 127=[0]111_1111)
// Sin signo: Podemos usar UInt<8|16|32|64> en lugar Int<8|16|32|64>
//            Todos los bits se asumen positivos
//            Para 8-bits el rango es de (0=0000_0000, 255=1111_1111)

// El número -73:
// +73: [0]1001001 : 0100_1001
// -73: [1]0110110 : 1011_0110

let a : UInt8 = 0b1000_1100 // 140
let b : UInt8 = 0b1001_0011 // 147
//              ------------------
//           &+ 0b0001_1111 // 31
//            & 0b1000_0000 // 128
//            | 0b1001_1111 // 159
//            ^ 0b0001_1111 // 31

//let c1 = a + b // 287 -> ERROR: (OVERFLOW) SALE DEL RANGO
//
//print(c1)

let c2 = a &+ b // 31 -> Suma bit por bit para evitar overflow

print(c2) // 31

print(~a) // 115
print(~b) // 108
print(a & b) // 128
print(a | b) // 159
print(a ^ b) // 31

// Sobreescritura de operadores

struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
    
    // Operador infix <<+>>
    static func + (productoIzquiedo: Producto, productoDerecho: Producto) -> Producto {
        let productoResult = Producto(id: productoIzquiedo.id, nombre: productoIzquiedo.nombre, precio: productoIzquiedo.precio + productoDerecho.precio, existencias: productoIzquiedo.existencias + productoDerecho.existencias)
        return productoResult
    }
    
    // Operador postfix <<++>>
    static postfix func ++ (producto: Producto) -> Producto {
        return Producto(id: producto.id, nombre: producto.nombre, precio: producto.precio, existencias: producto.existencias + 1)
    }
    
    // Operador prefix <<++>>
    static prefix func ++ (producto: Producto) -> Producto {
        return Producto(id: producto.id, nombre: producto.nombre, precio: producto.precio, existencias: producto.existencias + 1)
    }
}

let productoCoca = Producto(id: 1, nombre: "Coca Cola", precio: 17.5, existencias: 10)
let productoGansito = Producto(id: 2, nombre: "Gansito", precio: 12.5, existencias: 20)

print(productoCoca + productoGansito)

var productoGalletasMarias = Producto(id: 3, nombre: "Galletas Marías", precio: 18.99, existencias: 0)

print(productoGalletasMarias)

// Prefix: Aplica el operador sobre la expresión
//         Al utilizar el producto ya vendrá incrementado
// Postfix: Aplica la expresión y al finalizar la operación
//          Al utilizar el producto será el original hasta el final

//            existencias: 1  ->  existencias: 2
print(Producto(id: 0, nombre: "", precio: 0, existencias: 1) + ++productoGalletasMarias)

//            existencias: 1  ->  existencias: 2
print(Producto(id: 0, nombre: "", precio: 0, existencias: 1) + productoGalletasMarias++)

// Operadores personalizados

// <a> >+< <b>
infix operator >+<: AdditionPrecedence

// <a> <+> <b>
infix operator <+>: AdditionPrecedence

extension Producto {
    
    static func >+< (productoA: Producto, productoB: Producto) -> Producto {
        return Producto(id: productoA.id, nombre: productoA.nombre, precio: productoA.precio + productoB.precio, existencias: productoA.existencias)
    }
    
    static func <+> (productoA: Producto, productoB: Producto) -> Producto {
        return Producto(id: productoA.id, nombre: productoA.nombre, precio: productoA.precio, existencias: productoA.existencias + productoB.existencias)
    }
    
}

print(productoCoca >+< productoGalletasMarias)
print(productoCoca <+> productoGansito)

extension Producto: Comparable, Equatable {
    
    static func < (lhs: Producto, rhs: Producto) -> Bool {
        return lhs.precio < rhs.precio
    }
    
    static func == (lhs: Producto, rhs: Producto) -> Bool {
        if lhs.id == rhs.id { return true }
        if  (lhs.id == 0 || rhs.id == 0) &&
            lhs.nombre == rhs.nombre &&
            lhs.precio == rhs.precio &&
            lhs.existencias == lhs.existencias {
            return true
        }
        return false
    }
    
}

print(productoCoca < productoGansito)
print(productoGansito < productoGalletasMarias)

print(productoGansito > productoGalletasMarias)

print(productoCoca == Producto(id: 0, nombre: "Coca Cola", precio: 17.5, existencias: 10))
print(productoCoca != Producto(id: 100, nombre: "Coca Cola", precio: 17.5, existencias: 10))
