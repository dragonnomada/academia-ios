class Jugador {

    let nombre: String
    var antigüedad: Int
    var valoracion: Double
    

    init(nombre: String, valoracion: Double) {
        self.nombre = nombre
        self.antigüedad = 0
        self.valoracion = valoracion
    }
    

    func describir() {
        print("\(self.nombre) (\(self.antigüedad) años) [\(self.valoracion)] \(self)")
    }

}

let plantilla : [Jugador] = [Jugador(nombre: "Eduardo", valoracion: 10),Jugador(nombre: "David", valoracion: 10)]

let valoracionesJugadores = plantilla.map(\.valoracion)

print(valoracionesJugadores)
