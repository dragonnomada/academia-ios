import UIKit

// PARÁMETROS -> BLOQUE

// FUNCIÓN -> RECICLABLE

// CLAUSURA -> DESECHABLE

// FIRMA/CAPARAZÓN (SIGNATURE) :=
//
//       (PARÁMETROS) -> RETORNO
//
// PARÁMETRO:
//
// <etiqueta externa> <etiqueta interna>: TIPO
//

// (Int, Int, Bool) -> String?
func agregarCarrito(index: Int, productIndex: Int, descuento: Bool) -> String? {
    print("Agregando al carrito \(index) el producto \(productIndex) con descuento \(descuento ? "SI" : "NO")")
    return nil
}

// Almacena una función con firma (Int, Int, Bool) -> String?
var foo: (Int, Int, Bool) -> String? = agregarCarrito

foo(4, 5, false)

// (Int, Int, Bool) -> String?
func agregarTienda(index: Int, ubicacionIndex: Int, abierta: Bool) -> String? {
    print("Agregando la tienda \(index) en la ubicación \(ubicacionIndex) \(abierta ? "ABIERTA" : "CERRADA") ")
    return nil
}

foo = agregarTienda

foo(4, 5, false)

foo = {
    a, b, c in
    print("Soy la clausura a=\(a) b=\(b) c=\(c)")
    return "Hola"
}

foo(4, 5, false)

foo = { print("\($0) \($1) \($2)"); return nil }

foo(4, 5, false)

func suma(a: Int, b: Int) -> Int {
    
    return a + b
    
}

func sumaNotifier(a: Int, b: Int, completion: (Int, Int, Int) -> Void) {
    
    let c = a + b
    
    completion(a, b, c)
    
}

func sumaCompletada(operando1: Int, operando2: Int, resultado: Int) {
    print("La suma se ha completado con \(operando1) + \(operando2) = \(resultado)")
}

sumaNotifier(a: 4, b: 5, completion: sumaCompletada)

sumaNotifier(a: 100, b: 200, completion: {
    operando1, operando2, resultado in
    print("CLAUSURA: \(operando1) + \(operando2) = \(resultado)")
})

sumaNotifier(a: 1000, b: 2000) {
    op1, op2, res in
    print("CLAUSURA ELEGANTE: \(op1) + \(op2) = \(res)")
}

sumaNotifier(a: 10000, b: 20000) { print("\($0) 😆 \($1) 👉 \($2)") }

func sumaPositivaNotifier(a: Int, b: Int, completion: (Int, Int, Int) -> Void, error: (String) -> Void) {
    
    let c = a + b
    
    if c >= 0 {
        completion(a, b, c)
    } else {
        error("La suma fué negativa >:/ \(c)")
    }
    
}

sumaPositivaNotifier(a: 1000, b: -3000) { a, b, c in
    print("Todo es increíble")
} error: { mensaje in
    print("Algo salió mal: \(mensaje)")
}

var nombre = "Anónimo"

let setNombre = {
    // La clausura captura la variable nombre
    // !!! PELIGROSO
    // No podemos evitar que las clausuras capturen
    // automáticamente referencias a variables externas
    // se podría:
    // * Atascar memoria
    // * Modificar variables sensibles
    // * Ejecutar acciones fuera de su hilo
    nombre = "Pepe \(Date.now)"
}

print(nombre)

setNombre()

print(nombre)

Thread.sleep(forTimeInterval: 5)

setNombre()

print(nombre)
