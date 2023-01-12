import UIKit

protocol Pago {
    
    var descripcion: String { get }
    var monto: Double { get }
    
    func pagar() -> String?
    
}

class Libro: Pago {
    
    var autor: String
    var titulo: String
    var año: Int
    
    /// CALCULADA
    var descripcion: String {
        "\(titulo) - \(autor) [\(año)]"
    }
    
    /// ALMACENADA
    var monto: Double
    
    init(autor: String, titulo: String, año: Int, precio: Double) {
        self.autor = autor
        self.titulo = titulo
        self.año = año
        self.monto = precio
    }
    
    func pagar() -> String? {
        return "Libro pagado"
    }
    
}

class Playera: Pago {
    
    var talla: String
    var color: UIColor
    var modelo: String
    
    /// CALCULADA
    var descripcion: String {
        "\(modelo) - \(color) [\(talla)]"
    }
    
    var precio: Double
    
    /// CALCULADA
    var monto: Double {
        switch talla {
        case "CH":
            return precio
        case "MD":
            return precio * 1.1
        case "LG":
            return precio * 1.2
        case "XG":
            return precio * 1.3
        default:
            return precio * 1.15
        }
    }
    
    init(talla: String, color: UIColor, modelo: String, precio: Double) {
        self.talla = talla
        self.color = color
        self.modelo = modelo
        self.precio = precio
    }
    
    func pagar() -> String? {
        return "Se ha pagado la playera (\(descripcion) [\(monto)]"
    }
    
}

class Oferta {
    
    var identifier: String?
    
    var source: Pago?
    var destination: Pago?
    
}

let oferta1 = Oferta()

oferta1.identifier = "CompraLibroHarryGratisPlayeraHarry"

oferta1.source = Libro(autor: "J.K Rolling", titulo: "Harry Potter", año: 1996, precio: 289.78)

oferta1.destination = Playera(talla: "XG", color: .white, modelo: "Harry", precio: 125.89)

let oferta2 = Oferta()

oferta2.identifier = "CompraPlayeraHermayoniGratisLibroEmma"

oferta2.source = Playera(talla: "CH", color: .red, modelo: "Hermayoni", precio: 689.66)

oferta2.destination = Libro(autor: "Emma Watson", titulo: "Mi lucha", año: 2022, precio: 76.99)

func seguirTransaccion(oferta: Oferta) {
    
    switch oferta.identifier {
        
    case "CompraLibroHarryGratisPlayeraHarry":
        if let playeraHarry = oferta.destination as? Playera {
            print(playeraHarry.modelo)
        }
    case "CompraPlayeraHermayoniGratisLibroEmma":
        if let libroEmma = oferta.destination as? Libro {
            print(libroEmma.autor)
        }
    default:
        print("Oferta no identificada")
    }
    
}

func seguirTransaccionModificada(oferta: Oferta) {
    
    if let playeraHarry = oferta.destination as? Playera {
        print(playeraHarry.modelo)
    }
    
    if let libroEmma = oferta.destination as? Libro {
        print(libroEmma.autor)
    }
    
}
