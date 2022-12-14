import UIKit

// FIRMA: (String) -> Bool
func cuandoMensajeEsHola(mensaje: String) -> Bool {
    return mensaje == "Hola"
}

// Una función puede recibir como parámetro otra función
// si le especificamos la nomenclatura (sign/firma)
// de la función que se espera

func imprimir(mensaje: String, condicion: (String) -> Bool) {
    if condicion(mensaje) {
        print("Tu mensaje es: \(mensaje)")
    } else {
        print("No puedo imprimir tu mensaje: \(mensaje)")
    }
}

imprimir(mensaje: "Hola", condicion: cuandoMensajeEsHola)
imprimir(mensaje: "Mundo", condicion: cuandoMensajeEsHola)

func comienzaConA(mensaje: String) -> Bool {
    return mensaje.starts(with: "A")
}

imprimir(mensaje: "Albaca", condicion: comienzaConA)
imprimir(mensaje: "Halbaca", condicion: comienzaConA)

struct Producto {
    var id: Int
    var nombre: String
    var precio: Double
}

func reportarProducto(producto: Producto, sePuedeReportar condicion: (Producto) -> Bool) {
    if condicion(producto) {
        print("Producto [\(producto.id)] \(producto.nombre) cuesta $\(producto.precio)")
    } else {
        print("El producto [\(producto.id)] \(producto.nombre) no puede ser reportado")
    }
}

func precioCaro(producto: Producto) -> Bool {
    return producto.precio >= 10_000
}

func nombreEmpiezaConG(producto: Producto) -> Bool {
    return producto.nombre.starts(with: "G")
}

func esProductoIdPar(_ producto: Producto) -> Bool {
    return producto.id % 2 == 0
}

let productoCoca = Producto(id: 1, nombre: "Coca Cola", precio: 17.5)
let productoMac = Producto(id: 2, nombre: "Macbook", precio: 23_500.2)
let productoGansito = Producto(id: 8, nombre: "Gansito", precio: 23.5)

print("--- Producto caros ---")

reportarProducto(producto: productoCoca, sePuedeReportar: precioCaro)
reportarProducto(producto: productoMac, sePuedeReportar: precioCaro)
reportarProducto(producto: productoGansito, sePuedeReportar: precioCaro)

print("--- Producto que empiezan con G ---")

reportarProducto(producto: productoCoca, sePuedeReportar: nombreEmpiezaConG)
reportarProducto(producto: productoMac, sePuedeReportar: nombreEmpiezaConG)
reportarProducto(producto: productoGansito, sePuedeReportar: nombreEmpiezaConG)

print("--- Producto con ID par ---")

reportarProducto(producto: productoCoca, sePuedeReportar: esProductoIdPar)
reportarProducto(producto: productoMac, sePuedeReportar: esProductoIdPar)
reportarProducto(producto: productoGansito, sePuedeReportar: esProductoIdPar)

// Una función se puede fiar de otra función

// Pero surge un problema (una molestia)
// Generalmente las funciones asociadas son desechables y nunca más las volveremos a ocupar

// Las clausuras son en sí mismas funciones, por lo que
// en lugar de pasar una función, podemos pasar una clausura

// TIPO 1: Función general o clausura bloque
// * No captura parámetros de entrada

let bloque1 = {
    print("Hola mundo")
}

bloque1() // imprime "Hola mundo"

// TIPO 2: La clausura es equivalente a una función completa
//         que captura parámetros de entrada y parámetros de salida
//         para ejecutar un bloque con la salida esperada salida

// La clausura tiene 3 momentos:
// 1. Captura de parámetros
// 2. Separación `in`
// 3. Bloque de ejecución y retorno

// FIRMA: (Int, Int) -> Int
let suma = {
    (a: Int, b: Int) -> Int
    
    in

    // TODO: Lógica
    return a + b
}

// FIRMA: (Int, Int) -> Int
//func suma(a: Int, b: Int) -> Int {
//    return a + b
//}

let resultado = suma(123, 1000) // 1123

print(resultado) // Imprime 1123

// TIPO 2.5: Los parámetros y salida pueden ser inferidos**, por ejemplo
//         se puede inferir el tipo de los parámetros y el tipo de la salida*
// * Si la ejecución es el puro retorno, return puede omitirse
// ** Sólo si logra inferir la firma, puede omitir los parámetros
//    generalmente no lo podrá conseguir en funciones genéricas

let suma2: (Int, Int) -> Int = { (a, b) in a + b }

let resultado2 = suma2(100, 200) // 300

print(resultado2)

// TIPO 2.6: Se pueden usar directamente las clausuras en funciones
//           que esperan a otras funciones

reportarProducto(producto: productoCoca, sePuedeReportar: { producto in producto.precio < 20 })
reportarProducto(producto: productoCoca, sePuedeReportar: { producto in producto.nombre.starts(with: "H") })

// Las clausuras pueden externalizarse y sacarse de los parámetros, para funcionar
// en su modo incrustado/externalizado

reportarProducto(producto: productoGansito) { producto in producto.id == 8 }

// SINTAXIS: <función>(<parámetros>) <etiqueta 1> { <clausura 1> } <etiqueta 2>: { <clausura 2> } ...

//reportarProducto(producto: productoGansito)
//    sePuedeReportar: { producto in producto.id == 8 }
//    otraEtiqueta: { producto in producto.id == 8 }

// TIPO 3: Podemos omitir los parámetros y el separador `in`
//         para dejar sólo al bloque de retorno
//         conviniendo usar $0 para el primer parámetro
//         $1 para el segundo, y así sucesivamente

//let suma3 : (Int, Int) -> Int = {
//    let r = $0 + $1
//    return r
//}

let suma3 : (Int, Int) -> Int = { $0 + $1 }

let resultado3 = suma3(1_000, 4_000) // 5000

print(resultado3) // Imprime 5000

// TIPO 3.5: Cuándo el retorno esperado es un operador binario
//           podemos utilizar el simple operador equivalente

func incrementar(anterior: Int, actual: Int, calculaSiguiente: (Int, Int) -> Int) -> Int {
    
    let siguiente = calculaSiguiente(anterior, actual)
    
    return siguiente

}

let s1 = incrementar(anterior: 1, actual: 1, calculaSiguiente: { $0 + $1 }) // 2
let s2 = incrementar(anterior: 1, actual: 2, calculaSiguiente: { $0 + $1 }) // 3
let s3 = incrementar(anterior: 2, actual: 3, calculaSiguiente: { $0 + $1 }) // 5
let s4 = incrementar(anterior: 3, actual: 5, calculaSiguiente: { $0 + $1 }) // 8
let s5 = incrementar(anterior: 5, actual: 8, calculaSiguiente: { $0 + $1 }) // 13

var a = 1
var b = 1

for _ in 1...20 {
//    let c = incrementar(anterior: a, actual: b) { $0 + $1 }
    let c = incrementar(anterior: a, actual: b, calculaSiguiente: +)
    print(c)
    a = b
    b = c
}


