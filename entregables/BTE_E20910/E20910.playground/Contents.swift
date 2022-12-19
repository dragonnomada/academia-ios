struct Cafetera {
    let modelo: String
    let capacidadAgua: Double
    let capacidadCafe: Double
    var contenidoAguaActual: Double {
        willSet(nuevoContenidoAgua){
            if nuevoContenidoAgua > capacidadAgua || nuevoContenidoAgua < 0 {
                print("Error en los valores introducidos para la capacidad del Agua")
                // Error!
            }
        }
        didSet(contenidoAguaAnterior){
            if contenidoAguaActual > contenidoAguaAnterior + 100 {
                print("No puedes agregar mas de 100ml de agua por cada intento")
                // Error!
            }
        }
    }
    var contenidoCafeActual: Double {
            willSet(nuevoContenidoCafe){
            if nuevoContenidoCafe > capacidadCafe || nuevoContenidoCafe < 0 {
                print("Error en los valores introducidos para la capacidad del Cafe")
                // Error!
            }
        }
    }

    init(modelo: String, capacidadAgua: Double, capacidadCafe: Double){
        self.modelo = modelo
        self.capacidadAgua = capacidadAgua
        self.capacidadCafe = capacidadCafe
        self.contenidoAguaActual = 0.0
        self.contenidoCafeActual = 0.0
    }
}

var coffe = Cafetera(modelo: "M-01", capacidadAgua: 12_000.00, capacidadCafe: 140.00)

coffe.contenidoAguaActual = 100.00
//coffe.contenidoAguaActual = 101.00

print("Contenido de Agua en la cafetera: \(coffe.contenidoAguaActual)")
