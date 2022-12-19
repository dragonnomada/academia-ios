struct Cafetera {
    let modelo: String
    let capacidadAgua: Double
    let capacidadCafe: Double
    var contenidoAguaActual: Double
    var contenidoCafeActual: Double

    var estaVaciaAgua: Bool {
        get { contenidoAguaActual <= 0 }
    }

    var estaVaciaCafe: Bool {
        get { contenidoCafeActual <= 0 }
    }
}
