/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 13-12-22
 
 Practica 22 - Diseño Orientado a Protocolos
 */
import UIKit


//Estructura PuntoZona
struct PuntoZona {
    let id: String
    let latitud: Double
    let longitud: Double
 }

//Estructua Paquete
struct Paquete {
     let id: String
     let idCliente: String
     var puntoZona: PuntoZona?
     var guia: String?
 }

//Protocolo EmbaladorPaqueteProtocol
protocol EmbaladorPaqueteProtocol {
    // Retendra un Paquete
     var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
     func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete
 }

//Protocolo AsignadorGuiaPaqueteProtocol
protocol AsignadorGuiaPaqueteProtocol {
    //Asigna una guia a un paquete
     var paquetesConGuia: [(paquete: Paquete, guia: String)] { get }
     func asignarGuiaPaquete(paquete: Paquete, guia: String?) -> String
 }

//Protocolo MacadorPuntoZonaPaqueteProtocol
protocol MacadorPuntoZonaPaqueteProtocol {
     var paquetesMarcadosConPuntoZona: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
     func marcarPuntoZonaPaquete(paquete: Paquete, puntoZona: PuntoZona) -> Bool
 }

//Protocolo ReportadorEmbalajesProtocol
protocol ReportadorEmbalajesProtocol {
    
    func reportarEmbalajes ()
    
}

//Protocolo ReportadorGuiasProtocol
protocol ReportadorGuiasProtocol {
    func reportarGuias ()
}

//Protocolo ReportadorRutasProtocol
protocol ReportadorRutasProtocol {
    func reportarRutas (_ : EmbaladorPaqueteProtocol)
}

//Clase DHL
class DHL: EmbaladorPaqueteProtocol {
    
    var contador: Int = 1
    
    //Implementacion del protocolo EmbaladorPaqueteProtocol
    var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] = []
    
    func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete {
        
        var paquete = Paquete(id: "\(contador)", idCliente: "0987")
        contador += 1
        paquetesEmbalados.append( (paquete: paquete, puntoZona: puntoZona) )
        return paquete
    }
    
    
    //Implementacion del Protocolo AsignadorGuiaPaqueteProtocol
    var paquetesConGuia: [(paquete: Paquete, guia: String)] = []
    func asignarGuiaPaquete(paquete: Paquete, guia: String?) -> String {
        
        var paquete = Paquete(id: "\(contador)", idCliente: "0987")
        contador += 1
        paquetesConGuia.append((paquete: paquete, guia: "MX1234"))
        return "El paquete "
    }
}

//PRUEBAS UNITARIAS
var PuntoZonaCDMX = PuntoZona(id: "CDMX1", latitud: 5, longitud: 6)

var paqDHL = DHL()
var paqDHL2 = DHL()

paqDHL.embalarPaquete(idCliente: "Emiliano12", puntoZona: PuntoZonaCDMX)
paqDHL.embalarPaquete(idCliente: "Emiliano12", puntoZona: PuntoZonaCDMX)
paqDHL2.embalarPaquete(idCliente: "CDMX1", puntoZona: PuntoZonaCDMX)

for (paquete, zona) in paqDHL.paquetesEmbalados {
    print("El id del paquete numero \(paquete.id), de el cliente \(paquete.idCliente), en zona \(zona.id)")
}

