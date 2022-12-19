/*
Joel Brayan Navor Jimenez
    [E20917] - Crear una clase llamada Jarra con las caracteríscas de una jarra (capacidad, límites, etc) con métodos como (llenar, vaciar, etc).

    [E20918] - Crear una clase derivada de Jarra llamada Vaso que aumente el método sostener() y propiedad sostenido: Bool.

    [E20919] - Crear una clase derivada de Vaso llamada Taza que aumente el método esCaliente() y la propiedad caliente: Bool.

    [E20920] - Crear una clase derivada de Taza llamada Termo que aumente la propiedad abierto: Bool, sobreescriba el método llenar(), para impedir llenar el termo si no está abierto y lo mismo para vaciar().
*/

import Foundation 

class Jarra {
    let capacidad: Int 
    let limites: Int
    
    init(capacidad: Int, limites: Int){
        self.capacidad = capacidad
        self.limites = limites
    }
    func llenar() -> Bool{
        return true
    }

    func vaciar() -> Bool{
        return true
    }
}

class Vaso: Jarra{
    var sostenido: Bool = false

    func sostener() -> Bool {
        
        return sostenido == true
    }
}

class Taza: Vaso {
    var caliente: Bool = false

    func esCaliente() -> Bool {
        return caliente == true
    }
}

class Termo: Taza {
    var abierto: Bool = false

    override func llenar() -> Bool{
    if abierto == true {
        return true
    }
    return false
    }

    override func vaciar() -> Bool {
    if abierto == true {
        return true
    }
    return false
    }
}