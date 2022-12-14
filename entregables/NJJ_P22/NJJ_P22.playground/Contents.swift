/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
  Creado el 13 de Diciembre de 2022
  Practica 22 - Diseño Orientado a Protocolos
*/

import UIKit
//Creacion de la estructura PuntoZona
struct PuntoZona {
    let id: String
    let latitud: Double
    let longitud: Double
}


//El paquete es la estampa de los datos que tenemos en algún momento
struct Paquete {
    let id: String
    let idCliente: String
    var puntoZona: PuntoZona?
    var guia: String?
}
//Creacion del protocolo EmbaladorPaqueteProtocol
protocol EmbaladorPaqueteProtocol {
    var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
    func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete
}
//Creacion del protocolo AsignadorGuiaProtocol
protocol AsignadorGuiaPaqueteProtocol {
    var paquetesConGuia: [(paquete: Paquete, guia: String)] { get }
    func asignarGuiaPaquete(paquete: Paquete, guia: String?) -> String
}
//creacion del protocolo Marcador Punto Zona
protocol MacadorPuntoZonaPaqueteProtocol {
    var paquetesMarcadosConPuntoZona: [(paquete: Paquete, puntoZona: PuntoZona)] { get }
    func marcarPuntoZonaPaquete(paquete: Paquete, puntoZona: PuntoZona) -> Bool
}
//Protocolo ReportarEmbalajesProtocol
protocol ReportarEmbalajesProtocol {
    func reportarEmbalajes(embalador: EmbaladorPaqueteProtocol)
}
//Protocolo ReportarPaquetesConGuiasProtocol
protocol ReportarPaquetesConGuiasProtocol {
    func reportarPaquetesConGuia(asignadorGuia: AsignadorGuiaPaqueteProtocol)
    
}
//Protocolo ReportarRutasProtocol
protocol ReportarRutasProtocol {
    func reportarRutasProtocol(_: EmbaladorPaqueteProtocol)
}
//Creacion de la clase paqueteria
class Paqueteria: EmbaladorPaqueteProtocol{
    //Creacion de mi variable
    var contador = 0
    //generacion de una tupla vacia con los datos iniciales para paquetes embalados
    var paquetesEmbalados: [(paquete: Paquete, puntoZona: PuntoZona)] = []
    
    //Funcion encargada de agregar un paquete embalado
    func embalarPaquete(idCliente: String, puntoZona: PuntoZona) -> Paquete {
        //creacion de la variable paquete con los datos de la id del paquete y la id del cliente al que pertenece el paquete
        var paquete = Paquete(id: "\(contador)", idCliente: idCliente)
        //Sumo mi contador
        contador += 1
        //agregando la variable a mi tupla vacia
        paquetesEmbalados.append((paquete: paquete, puntoZona: puntoZona))
        //retornamos el paquete
        return paquete
    }
    
}
//Creacion de mi clase fedex para usar mi protocolo AsignadorGuiaPaqueteProtocol
class Fedex: AsignadorGuiaPaqueteProtocol{
    // agrego una variable contador para agregarle una id a mi paquete (provicional)
    var contador = 0
    //Inicializadores para paquetes con guia
    var paquetesConGuia: [(paquete: Paquete, guia: String)] = []
    //funcion que agrega la guia a mi paquete
    func asignarGuiaPaquete(paquete: Paquete, guia: String?) -> String {
        var paquete = Paquete(id: "\(contador)", idCliente: "1")
        //Sumo mi contador
        contador += 1
        paquetesConGuia.append((paquete: paquete, guia: "RDTF12AS"))
        return "El paquete con el id: \(paquete.id), con el numero de guia \(paquete.id)"
    }
    
    
}


//Pruebas Unitarias
let puntoZonaPerisur = PuntoZona(id: "Perisur", latitud: 123.0, longitud: 12.12)
// creacion de mis paqueterias que implementan a mi clase paqueteria
var paqueteriaAmazon = Paqueteria()
var paqueteriaDHL = Paqueteria()
//haciendo uso de mis paqueterias que hacen uso de las funciones dentro de mi clase que hacen uso de mis protocolo embalar
paqueteriaAmazon.embalarPaquete(idCliente: "RTSFR12", puntoZona: puntoZonaPerisur)
paqueteriaAmazon.embalarPaquete(idCliente: "YSHDA123", puntoZona: puntoZonaPerisur)

paqueteriaDHL.embalarPaquete(idCliente: "ASDY123HAS", puntoZona: puntoZonaPerisur)
paqueteriaDHL.embalarPaquete(idCliente: "JOSUQWEL123", puntoZona: puntoZonaPerisur)

//Reportando el embalaje de mis paquetes embalados en mis paqueterias
print("Embalajes de amazon")
//1.
for (paquete, zona) in paqueteriaAmazon.paquetesEmbalados {
    print("El id del paquete es \(paquete.id), para el cliente \(paquete.idCliente), en la zona \(zona.id)")
}

print("Embalajes de DHL")
for (paquete, zona) in paqueteriaDHL.paquetesEmbalados {
    print("El id del paquete es \(paquete.id), para el cliente \(paquete.idCliente), en la zona \(zona.id)")
}



