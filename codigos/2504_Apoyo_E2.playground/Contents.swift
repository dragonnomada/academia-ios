import UIKit

protocol Paquete {
    
    var id: Int { get }
    var descripcion: String { get }
    var existencias: Int { get set }
    var almacenado: Bool { get set }
    
}

protocol Almacen {
    
    func obtenerPaquetePorId(id: Int) -> Paquete?
    func ingresarPaquete(paquete: Paquete, existencias: (Paquete) -> Int)
    func retirarPaquete(actualizador: (Paquete) -> Int)
    func reportarPaquetes(reportador: (Paquete) -> String)
    
}

struct PaqueteAmazon: Paquete {
    let id: Int
    let descripcion: String
    var existencias: Int = 0
    var almacenado: Bool = false
    
}

class AlmacenAmazon: Almacen {
    
    var paquetes: [Paquete] = []
    
    func obtenerPaquetePorId(id: Int) -> Paquete? {
        // recorrer cada paquete
        // y si el paquete tiene el id devolverlo
        
        // si termina y no se encontró devolver nil
        return nil
    }
    
    func ingresarPaquete(paquete: Paquete, existencias: (Paquete) -> Int) {
        var paquetePorAlmacenar = paquete
        paquetePorAlmacenar.existencias = existencias(paquete)
        paquetePorAlmacenar.almacenado = true
        paquetes.append(paquete)
    }
    
    func retirarPaquete(actualizador: (Paquete) -> Int) {
        for i in 0..<paquetes.count {
            paquetes[i].existencias = actualizador(paquetes[i])
        }
    }
    
    func reportarPaquetes(reportador: (Paquete) -> String) {
        // Recorrer cada paquete
        // imprimir en una linea lo que devuelva el reportador
    }
    
}

let paquete1 = PaqueteAmazon(id: 1, descripcion: "Zapatos")
let paquete2 = PaqueteAmazon(id: 2, descripcion: "Sandalias")
let paquete3 = PaqueteAmazon(id: 3, descripcion: "Tenis")

let almacen = AlmacenAmazon()

almacen.ingresarPaquete(paquete: paquete1) { paquete in return 10 }
almacen.ingresarPaquete(paquete: paquete2) { paquete in return 5 }
almacen.ingresarPaquete(paquete: paquete3) { paquete in return 20 }

almacen.reportarPaquetes { paquete in return "[\(paquete.id)] \(paquete.descripcion) (\(paquete.existencias)) [\(paquete.almacenado ? "ALMACENADO" : "SIN ALMACENAR")]" }

almacen.retirarPaquete {
    paquete in
    if paquete.id == 2 {
        return 0
    } else {
        return paquete.existencias
    }
}
