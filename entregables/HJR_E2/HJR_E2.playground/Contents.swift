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

//Protocolo AlmacenProtocol
protocol AlmacenProtocol {
   
    func obtenerPaquetePorId (id: Int) -> PaqueteAmazon?
    func ingresarPaquete(paquete: PaqueteAmazon, existencias: (PaqueteAmazon) -> Int)
    func retirarPaquete(actualizador: (PaqueteAmazon) -> Int)
    func reportarPaquetes(reportador: (PaqueteAmazon) -> String)
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

    // Filtramos en el arreglo "paquetes", buscando la existencia
    // de un paquete po r id, si lo encuentra lo devolvera
    // y si no, ns regresara nil
    func obtenerPaquetePorId(id: Int) -> PaqueteAmazon? {
        for paquete in paquetes {
            if paquete.id == id {
                return paquete
            }
        }
        return nil
    }

    // Ingreso de paquetes nuevos al arreglo "paquetes"
    func ingresarPaquete(paquete: PaqueteAmazon, existencias: (PaqueteAmazon) -> Int) {
        var paquetePorAlmacenar = paquete
        paquetePorAlmacenar.existencias = existencias(paquete)
        paquetePorAlmacenar.almacenado = true
        paquetes.append(paquete)
    }

    // Funcion que nos ayuda a retirar un paquete.
    func retirarPaquete(actualizador: (PaqueteAmazon) -> Int) {
       
        for i in 0..<paquetes.count {
            paquetes[i].existencias = actualizador(paquetes[i])
        }
    }

    // Generacion del reporte de los paquetes que exisetn en el
    // arreglo "paquetes"
    func reportarPaquetes(reportador: (PaqueteAmazon) -> String) {
        for paquete in paquetes {
            print(reportador(paquete))
        }
    }
 }

// PRUEBAS UNITARIAS

// Generacion de paquetes
let paquete1 = PaqueteAmazon(id: 1, descripcion: "Zapatos")
let paquete2 = PaqueteAmazon(id: 2, descripcion: "Sandalias")
let paquete3 = PaqueteAmazon(id: 3, descripcion: "Tenis")

// Generacion de una instancia de la clase AlmacenAmazon
let almacen = AlmacenAmazon()

// Ingresar paquetes al arreglo "paquetes"
almacen.ingresarPaquete(paquete: paquete1) { paquete in return 10 }
almacen.ingresarPaquete(paquete: paquete2) { paquete in return 5 }
almacen.ingresarPaquete(paquete: paquete3) { paquete in return 20 }

// Generacion del reporte de los paquetes.
almacen.reportarPaquetes { paquete in return "[\(paquete.id)] \(paquete.descripcion) (\(paquete.existencias)) [\(paquete.almacenado ? "ALMACENADO" : "SIN ALMACENAR")]" }

// Retirar un paquete
almacen.retirarPaquete {
    paquete in
    if paquete.id == 2 {
        return 0
    } else {
        return paquete.existencias
    }
}
