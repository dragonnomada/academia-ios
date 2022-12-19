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


class Almacen {

    var productos: [Producto]
    var limite: Int

    init(limiteInicial: Int) {
        self.productos = []
        self.limite = limiteInicial
    }


    func agregarProducto(producto: Producto) -> Bool {
        if (self.productos.count < self.limite) {
            self.productos.append(producto)
            return true
        } else {
            return false
        }
    }


    func capacidadDisponible() -> Int {
        return self.limite - self.productos.count
    }
}

var amazon = Almacen(limiteInicial: 10)

let telefono = Producto(nombreInicial: "Samnsung", precioInicial: 2175.16, existenciasIniciales: 10)

amazon.agregarProducto(producto: telefono)

print(amazon.productos)

print(amazon.capacidadDisponible())

