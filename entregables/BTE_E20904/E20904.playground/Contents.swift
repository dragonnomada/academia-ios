struct Jarra {

    var contenidoActual: Double
    var capacidad: Double

    init(capacidad: Double) {
        self.capacidad = capacidad
        self.contenidoActual = 0.0
    }

    mutating func vaciar() {
        self.contenidoActual = 0.0
    }

    mutating func llenar() {
        self.contenidoActual = capacidad
    }

    mutating func agregar(mililitros: Double){
        if self.contenidoActual + mililitros <= capacidad {
            self.contenidoActual+=mililitros
        } else {
            self.llenar()
        }
    }

    func estaVacio() -> Bool {
        return self.contenidoActual <= 0.0
    }
    
    func estaLleno() -> Bool {
        return self.contenidoActual >= capacidad
    }

}


var jarritoA = Jarra(capacidad: 1_500)
var copiaJarritoA = jarritoA

jarritoA.llenar()

copiaJarritoA.agregar(mililitros: 1_000)

print("Capacidad Jarrito A: \(jarritoA.contenidoActual)")

print("Capacidad de la copia de Jarrito A: \(copiaJarritoA.contenidoActual)")
