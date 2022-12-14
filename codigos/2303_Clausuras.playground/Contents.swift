import UIKit

class A {
    
    init() {
        print("Una instancia de A ha sido generada")
    }
    
    deinit {
        print("Una instancia de A ha sido liberada")
    }
    
}

// Es una instancia que vive todo el programa,
// se libera hasta que el programa termina
// * Las instancias viven en la memoria del montículo (memory-heap)
let a1 = A()

// Las instancias opcionales se liberan automáticamente
// cuándo las ajustamos a nil
// * En realidad quita una referencia y si la instancia
//   ya no tiene referencias la instancia es liberada automáticamente
//   esto lo veremos a detalle en el manejo de ARC (Automatic Count Reference)
var a2 : A? = A() // [+1: 1]

a2 = nil // [-1: 0] -> Se libera

// El primer tipo de una clasura se llama función global o bloque

// bloque1: Es una función global
// () -> Void
let bloque1 = {
    // Una clausura captura variables y al terminar las libera
    let a3 = A()
}

// Cuándo atrapamos una clausura en una variable
// esto se conoce como una función anónima o función global
// Es decir, la variable que atrapa la clausura no es
// una varible, sino una función capaz de ejecutar el bloque
// atrapado

print("--- Prueba 1 ---")

bloque1()

print("--- Prueba 2 ---")

bloque1()

// Conclusión:
// Las clausuras capturan valores (o instancias)
// y al finalizar liberan la memoria

// Las clausuras sirven para crear bloques funcionales
// que pueden ser guardados como variables

// Por ejemplo, si una función necesita a otra función
// para devolverle el resultado o avisarle que ya acabó

func generaPrimos(_ total: Int) -> [Int] {
    
    var primos : [Int] = []
    
    var n = 2
    
    while primos.count < total {
        
        // Para comprobar si n es un número primo
        // debemos suponer que si lo es
        // y recorrer cada uno de los otros primos
        // para determinar que si n es múltiplo de algún primo
        // entonces n ya no será un número primo
        // si n se mantiene primo al final, significará
        // que n no es múltiplo de otros primos
        // por lo que n será un número primo
        
        var esPrimo = true
        
        for primo in primos {
            if n % primo == 0 {
                esPrimo = false
                break
            }
        }
        
        if esPrimo {
            primos.append(n)
        }
        
        n += 1
        
    }
    
    return primos
    
}

print(generaPrimos(20))

func generaPrimosInfinito() {
    
    var primos : [Int] = []
    
    var n = 2
    
    while true {
        
        // Para comprobar si n es un número primo
        // debemos suponer que si lo es
        // y recorrer cada uno de los otros primos
        // para determinar que si n es múltiplo de algún primo
        // entonces n ya no será un número primo
        // si n se mantiene primo al final, significará
        // que n no es múltiplo de otros primos
        // por lo que n será un número primo
        
        var esPrimo = true
        
        for primo in primos {
            if n % primo == 0 {
                esPrimo = false
                break
            }
        }
        
        if esPrimo {
            primos.append(n)
            print("El primo es: \(n)")
        }
        
        n += 1
        
        Thread.sleep(forTimeInterval: TimeInterval(0.5))
        
    }
    
}

generaPrimosInfinito()

func generaPrimosInfinitoDelegate(onPrimo: (Int) -> Void) {
    
    var primos : [Int] = []
    
    var n = 2
    
    while true {
        
        // Para comprobar si n es un número primo
        // debemos suponer que si lo es
        // y recorrer cada uno de los otros primos
        // para determinar que si n es múltiplo de algún primo
        // entonces n ya no será un número primo
        // si n se mantiene primo al final, significará
        // que n no es múltiplo de otros primos
        // por lo que n será un número primo
        
        var esPrimo = true
        
        for primo in primos {
            if n % primo == 0 {
                esPrimo = false
                break
            }
        }
        
        if esPrimo {
            primos.append(n)
            print("El primo es: \(n)")
        }
        
        n += 1
        
        Thread.sleep(forTimeInterval: TimeInterval(0.5))
        
    }
    
}
