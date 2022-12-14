import UIKit

/*
 Eduardo Batista (batista.eduardo.mat@gmail.com)
 
 Creado 12 diciembre 2022
 
 Practica 21 - Manejo de estructuras, clase y protocolos.
 
 */

// Funcion que que extiende a la  clase String para generar un cadena aleatoria
extension String {

    static func random(_ length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

struct PuntoZona {
    let id: String
    let latitud: Double
    let longitud: Double
}

// El paquete es la estampa de los datos que tenemos en algún momento
struct Paquete {
    let id: String
    let idCliente: String
    var puntoZona: PuntoZona?
    var guia: String?
}

protocol EmbaladorPaqueteProtocol {
    var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
    func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete
}

protocol AsignadorGuiaPaqueteProtocol {
    var paquetesConGuia: [(paquete: Paquete, guia: String)] { get }
    func asignarGuiaPaquete(paquete: Paquete, guia: String?) -> String
}

protocol MacadorPuntoZonaPaqueteProtocol {
    var paquetesMarcadosConPuntoZona: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
    func marcarPuntoZonaPaquete(paquete: Paquete, puntoZona: PuntoZona) -> Bool
}

protocol ReportadorEmbalajesProtocol {
    func reportarEmbalajes(embalador: EmbaladorPaqueteProtocol)
}

protocol ReportadorGuiasProtocol {
    func reportarGuias(embalador: EmbaladorPaqueteProtocol)
}

protocol ReportadorRutasProtocol {
    func reportarRutas(embalador: EmbaladorPaqueteProtocol)
}

class EmbaladorPaquetes: EmbaladorPaqueteProtocol {
    // Implementamos la variable del protocolo y la inicializamos como
    var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] = []
    
    
    func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete {
        // Generamos un paquete con un ID random y El idCliente
        var paquete = Paquete(id: String.random(14), idCliente: idCliente)
        // Agregamos a la lista el nuevo paquete
        paquetesEmbalados.append((paquete, puntoZona))
        return paquete
    }
}

class ReportadorEmbalajes: ReportadorEmbalajesProtocol {
    
    func reportarEmbalajes(embalador: EmbaladorPaqueteProtocol){
        // Por cada paquete que contenga el embalador imprimos el Formato
        for paqueteInfo in embalador.paquetesEmbalados{
            print("----------------------------------")
            print("ID PAQUETE:\t\t [\(paqueteInfo.paquete.id)]")
            print("ID CLIENTE:\t\t [\(paqueteInfo.paquete.idCliente)]")
            print("ID PUNTO ZONA:\t [\(paqueteInfo.puntoZona.id)]")
            print("---------------------------------")
        }
    }
}
// Creamos el Punto de la Zona de la Condesa con su respectiva ubicación (latitud, longitud)
let puntoZonaLaCondesa = PuntoZona(id: "Condesa\(String.random(6))", latitud: 12.0, longitud: 2.1)

// Generamos dos Embaladores para Amazon y DHL de la clase encargada en Embalar
var amazonDistibuidor = EmbaladorPaquetes()
var dhlDistribuidor = EmbaladorPaquetes()

// Encargamos de embalar un paquete en Amazon con us IdCliente y su PuntoZona en la Condesa
amazonDistibuidor.embalarPaquete(idCliente: "Amazon\(String.random(6))", puntoZona: puntoZonaLaCondesa)


// Encargamos de embalar dos paquetes en DHL con un mismo cliente en el PuntoZona la Condesa

dhlDistribuidor.embalarPaquete(idCliente: "PEPITO73", puntoZona: puntoZonaLaCondesa)
dhlDistribuidor.embalarPaquete(idCliente: "PEPITO73", puntoZona: puntoZonaLaCondesa)

// Creamos un Reportador de Embalajes de la clase ReportadorEmbalajes heredada del protocolo ReportadorEmbalajesProtocol
var amazonEmbarques = ReportadorEmbalajes()

//Imprimimos el reporte de embalajes de Amazon
print("AMAZON:")
amazonEmbarques.reportarEmbalajes(embalador: amazonDistibuidor)

//Imprimimos el reporte de embalajes de DHL
print("DHL:")
amazonEmbarques.reportarEmbalajes(embalador: dhlDistribuidor)
