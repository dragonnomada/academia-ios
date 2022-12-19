struct Producto {

    let nombre: String
    var precio: Double
    var existencias: Int

    init(nombreInicial: String, precioInicial: Double, existenciasIniciales: Int) {
        self.nombre = nombreInicial
        self.precio = precioInicial
        self.existencias = existenciasIniciales
    }

    func tieneExistencias() -> Bool {
        return self.existencias > 0
    }

}
