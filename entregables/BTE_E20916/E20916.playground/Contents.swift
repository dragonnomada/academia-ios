class Jugador {

    let nombre: String
    var antiguedad: Int
    var valoracion: Double


    init(nombre: String, valoracion: Double) {
        self.nombre = nombre
        self.antiguedad = 0
        self.valoracion = valoracion
    }
    
    func callAsFunction() -> Double {
        return Double(self.antiguedad) * self.valoracion
    }

    func describir() {
        print("\(self.nombre) (\(self.antiguedad) años) [\(self.valoracion)] \(self)")
    }

}
