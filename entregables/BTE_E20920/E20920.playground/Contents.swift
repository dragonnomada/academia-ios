class Jarra {

    var contenidoActual: Double
    var capacidad: Double

    init(capacidad: Double) {
        self.capacidad = capacidad
        self.contenidoActual = 0.0
    }

    func vaciar() {
        self.contenidoActual = 0.0
    }

    func llenar() {
        self.contenidoActual = capacidad
    }

    func agregar(mililitros: Double){
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

class Vaso: Jarra {
    let sostenido: Bool = true
    override init(capacidad: Double) {
        super.init(capacidad: capacidad)
    }
    func sostener() {
        if self.sostenido {
            print("Sostenido")
        }
        else {
            print("No se puede sostener")
        }
    }
}

class Taza: Vaso {
    let caliente: Bool = true
    override init(capacidad: Double) {
        super.init(capacidad: capacidad)
    }
    func esCaliente() -> Bool{
        return caliente
    }
}

class Termo: Taza {
    let abierto: Bool = true
    override init(capacidad: Double) {
        super.init(capacidad: capacidad)
    }
    
    override func llenar() {
        if abierto {
            print("Llenando Termo")
        } else {
            print("No se puede llenar: Destapar primero")
        }
    }
}
