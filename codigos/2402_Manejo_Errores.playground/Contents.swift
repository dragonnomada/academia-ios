import UIKit

// Manejo de Errores

// Estructuras principales para el manejo
// y propagación de errores

// 1. Función propagadora: Una función se puede marcar
//    con throws para indicar que en algún momento
//    (muy probable) ocurrirá un error incontrolable.
//    Entonces asumirá que quién mande a llamar a
//    la función será responsable de atrapar el error.

// 2. Atrapar el error: Controlar un error no esperado
//    do { try } catch .<errorEnum>(<params>) {}
// * Podemos controlar un error para
//   funciones que hayan marcado la posibilidad
//   de provocar un error (funciones propagadoras)

func fibonacci(n: Int) throws -> [Int] {
    var fibos : [Int] = []
    var a = 1
    var b = 1
    for _ in 3...n {
        let c = a + b
        fibos.append(c)
        a = b
        b = c
    }
    return fibos
}

//do {
//    try print(fibonacci(n: 100))
//} catch {
//    print("No pudieron generar los 100 números de fibonacci")
//}

// 2.5 Errores personalizados: A tráves de enumeraciones
//     que implementan el protocolo Error podemos diseñar
//     errores específicos con datos personalizados
//     para arrojar (propagar) errores más descriptivos
//     y sofisticados
// * Nota: tenemos que provocar un error y utilizar
//   nuestra enumeración

struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
}

// [1] Crear la enumeración de errores
enum CrearProductoError: Error {
    // Este caso soporta transportar un Double
    case precioNegativo(Double)
    case existenciasNegativas
}

func crearProductoFicticio(precio: Double, existencias: Int) throws -> Producto {
    
    if precio < 0 {
        // [2] Provocamos un error con alguna enumeración
        // * usamos: throw <enum: Error>
        // ** La enumeraciones soportan transporte de datos
        // *** Requiero colocar en la enumeración
        //     el valor transportado
        throw CrearProductoError.precioNegativo(precio)
    }
    
    if existencias < 0 {
        // [2] Provocamos un error con alguna enumeración
        throw CrearProductoError.existenciasNegativas
    }
    
    let id = Int.random(in: 1...1_000_000)
    return Producto(id: id, nombre: "Producto \(id)", precio: precio, existencias: existencias)
}

for _ in 1...10 {
    // [3] Controlamos los posibles errores
    do {
        // [3.1] Intentamos ejecutar la función
        //       marcada como throws
        //       (la función propagadora de errores)
        let producto = try crearProductoFicticio(precio: Double.random(in: -1_000...1_000), existencias: Int.random(in: -100...100))
        print(producto)
    // [3.2] Para cuándo la enumeración toma cada caso
    // * Podemos recuperar o no el valor transportado
    } catch CrearProductoError.precioNegativo(let precio) {
        print("El precio es negativo (\(precio)), no puedo crear el producto")
    } catch CrearProductoError.existenciasNegativas {
        print("Las existencias son negativas, no puedo crear el producto")
    } catch {
        print("Error desconocido, no puedo crear el producto")
    }
}

// 3. Manejo de errores condicionales: Podemos controlar
//    un error mediante opcionales en sus formas:
//    (1) VARIABLE
//    (2) IF-LET
//    (3) GUARD-LET
// * La idea es utilizar try? para o devolver el resultado
//   esperado o devolver nil (lugar de atrapar algún error)

func testCrearProductos1(precio: Double, existencias: Int) {
    
    print("--- Intendando crear un producto ---")
    print("Precio: $\(precio) Existencias: \(existencias)")
    
    // Atrapamos el resultado si no hay error
    
    let producto : Producto? = try? crearProductoFicticio(precio: precio, existencias: existencias)
    
    print(producto != nil ? producto! : "NIL")
    
    print("------------------------------------")
    
}

testCrearProductos1(precio: 19, existencias: 10)
testCrearProductos1(precio: -19, existencias: 10)
testCrearProductos1(precio: 19, existencias: -10)
testCrearProductos1(precio: -19, existencias: -19)

func testCrearProductos2(precio: Double, existencias: Int) {
    
    print("--- Intendando crear un producto ---")
    print("Precio: $\(precio) Existencias: \(existencias)")
    
    // Producto ya no es opcional
    // * El problema es tener anidación
    
    if let producto = try? crearProductoFicticio(precio: precio, existencias: existencias) {
        print(producto)
    } else {
        print("No se puedo crear")
    }
    
    print("------------------------------------")
    
}

testCrearProductos2(precio: 190, existencias: 100)
testCrearProductos2(precio: -190, existencias: 100)
testCrearProductos2(precio: 190, existencias: -100)
testCrearProductos2(precio: -190, existencias: -100)

func testCrearProductos3(precio: Double, existencias: Int) {
    
    print("--- Intendando crear un producto ---")
    print("Precio: $\(precio) Existencias: \(existencias)")
    
    guard let producto = try? crearProductoFicticio(precio: precio, existencias: existencias) else {
        print("Nel pastel")
        return
    }
    
    // Producto ya no es opcional
    
    print(producto)
    
    print("------------------------------------")
    
}

testCrearProductos3(precio: 1900, existencias: 1000)
testCrearProductos3(precio: -1900, existencias: 1000)
testCrearProductos3(precio: 1900, existencias: -1000)
testCrearProductos3(precio: -1900, existencias: -1000)

