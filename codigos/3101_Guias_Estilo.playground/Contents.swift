//
// Códigos de ayuda para las guías de estilo de código
//
// Por Alan Badillo Salas <dragonnomada123@gmail.com>
//
// Creado el 19 de diciembre de 2022.
//

/*
 
 Comentario tipo código múltilinea
 
 - Se utiliza para ideas importantes, el color es más brilloso
 - En este tipo de documentación no se soporta markdown
 - los enlaces https://google.com si son reconocibles
 - Su uso va orientado al código directamente
 
 */

/**
 
 Comentario tipo documentación múltilinea
 
 Se utiliza para documentación en general con soporte de markdow.
 
 El color es menos brilloso y el formato de texto menos ligado al **código**.
 
 * Tiene el soporte a markdown
 * Estos elementos serían de tipo lista
 * Podemos usar enlaces y tablas
 
 > Ejemplo de un `enlace`
 
 [Ir a google](https://google.com)
 
 > Ejemplo de una `tabla`
 
 Columna 1 | Columna 2 | Columna 3 | ... | Columna `N`
 --- | --- | --- | --- | --- | ---
 Valor 1.1 | Valor 2.1 | Valor 3.1 | ... | Valor `N`.1
 Valor 1.2 | Valor 2.2 | Valor 3.2 | ... | Valor `N`.2
 Valor 1.3 | Valor 2.3 | Valor 3.3 | ... | Valor `N`.3
 
 */

// Comentario de código de simple línea

/// Comentario de tipo documentación de simple línea (**soporta markdown**)

import UIKit

/**
 Regresa el valor de sumar dos enteros
 
 - Parameters:
    - a: Un entero con el primer valor a sumar
    - b: Un segundo entero con el valor a sumar
 
 - Returns: La suma de los enteros
 
 - Author: Alan Badillo <dragonnomada123@gmail.com>
 
 - Attention: Usa la versión genérica para otros tipos de datos
 Existe una versión genérica de la suma como [@sum](https://google.com)
 
 - Copyright: NomadaCode  © 2022
 [Aviso de política y privacidad](https://www.nomadacode.com)
 
 - Note:
 
 > Ejemplos
 
 Ejemplo | Descripción
 --- | ---
 `suma(1, 3) -> 4` | Si sumamos `1` y `3` el resultado esperado será `4`
 `suma(2, 5) -> 7` | Si sumamos `2` y `5` el resultado esperado será `7`
 
 ```swift
 let num1: Int = 1
 let num2: Int = 3
 let resultado = suma(a: num1, b: num2)
 print(resultado) // -> 4
 ```
 
 */
func suma(a: Int, b: Int) -> Int {
    return a + b
}

func imprime(texto contenido: String, veces n: Int) {
    
    for _ in 1...n {
        print(contenido)
    }
    
}

// CORRECTO
imprime(texto: "Hola mundo", veces: 5)
// INCORRECTO
//imprime("Hola mundo", 5)

/**
 Estructura `Producto`
 
 - Authors:
    Alan Badillo
    dragonnomada123@gmail.com
 
    John Wick
    john_wick@hotmail.com
 
    Ana Wong
    ana_wong@gmail.com
 
 - Note:
 Sirve para retener los datos de un producto
 */
struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
}

class ReportadorProductos {
    /**
     Genera un reporte con del producto
     
     - Parameters:
        - producto: [Producto](./Producto)
     */
    static func reportar(producto: Producto) {
        print(producto)
    }
}

ReportadorProductos.reportar(producto: Producto(id: 1, nombre: "Coca Cola", precio: 17.5))
