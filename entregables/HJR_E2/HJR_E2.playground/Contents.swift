/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 16-12-22
 
 Examen semana 2
 */
import UIKit

//Protocolo PaqueteProtocol
protocol PaqueteProtocol {
    
    var id: Int { get }
    var descripcion: String { get }
    var existencias: Int { get set }
    var almacenado: Bool { get set }
}

//Estructura PaqueteAmazon
struct PaqueteAmazon: PaqueteProtocol {
    
    let id: Int
    var descripcion: String
    var existencias = 0
    var almacenado = false
    
}

//Clase AlmacenAmazon
class AlmacenAmazon: AlmacenProtocol {
    
    var paquetes: [PaqueteAmazon] = []

    func obtenerPaquetePorId(id: Int) -> PaqueteAmazon? {
        for paquete in paquetes {
            if paquete.id == id {
                return paquete
            }
        }
        return nil
    }
    
    func ingresarPaquete(paquete: PaqueteAmazon, existencias: (PaqueteAmazon) -> Int) {
        var paquetePorAlmacenar = paquete
        paquetePorAlmacenar.existencias = existencias(paquete)
        paquetePorAlmacenar.almacenado = true
        paquetes.append(paquete)
    }
    
    func retirarPaquete(actualizador: (PaqueteAmazon) -> Int) {
        
        for i in 0..<paquetes.count {
            paquetes[i].existencias = actualizador(paquetes[i])
        }
    }
    
    func reportarPaquetes(reportador: (PaqueteAmazon) -> String) {
        for paquete in paquetes {
            print(reportador(paquete))
        }
    }
 }
 
//Protocolo AlmacenProtocol
protocol AlmacenProtocol {
    
    func obtenerPaquetePorId (id: Int) -> PaqueteAmazon?
    func ingresarPaquete(paquete: PaqueteAmazon, existencias: (PaqueteAmazon) -> Int)
    func retirarPaquete(actualizador: (PaqueteAmazon) -> Int)
    func reportarPaquetes(reportador: (PaqueteAmazon) -> String)
}

//PRUEBAS UNITARIAS

//Generacion de paquetes
let paquete1 = PaqueteAmazon(id: 1, descripcion: "Zapatos")
let paquete2 = PaqueteAmazon(id: 2, descripcion: "Sandalias")
let paquete3 = PaqueteAmazon(id: 3, descripcion: "Tenis")

//Generacion de almacen
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
 
