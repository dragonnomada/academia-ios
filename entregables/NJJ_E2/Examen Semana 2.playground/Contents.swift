import UIKit
/*
Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
16 Diciembre de 2022
Examen Semana 2
Protocolos, Estructuras, Clausuras
*/
//Creaciòn de mi protocolo paquet
protocol Paquete {
    
    var id: Int { get }
    var descripcion: String { get }
    var existencias: Int { get set }
    var almacenado: Bool { get set }
    
}
//Creaciòn del protocolo almacen
protocol Almacen {
    //Funciòn obtener paquete mediante ID
    func obtenerPaquete(id: Int ) -> Paquete?
    //Funcion para almacenar paquete
    func almacenarPaquete(paquete: Paquete, existencias: (Paquete)  -> Int)
    //Funciòn para Retirar paquete
    func retirarPaquete(actualizador: (Paquete) -> Int)
    //Funciòn para Reportar paquetes
    func reportarPaquetes(reportador: (Paquete)  -> String)
    
}
//Creaciòn de la estructura PaqueteAmazon
struct PaqueteAmazon : Paquete {
    let id: Int
    let descripcion: String
    var existencias: Int = 0
    var almacenado: Bool = false
}
//Creaciòn de la clase AlmacenAmazon
class AlmacenAmazon: Almacen {
    var paquetes: [Paquete] = []
    
    func retirarPaquete(actualizador: (Paquete) -> Int) {
        for i in 0..<paquetes.count {
            paquetes[i].existencias = actualizador(paquetes[i])
        }
    }
    
    func reportarPaquetes(reportador: (Paquete) -> String) {
        for paquete in paquetes {
            print(reportador(paquete))
        }
    }
    
    func almacenarPaquete(paquete: Paquete, existencias: (Paquete) -> Int) {
        //variable auxiliar
        var paquetePorAlmacenar = paquete
        paquetePorAlmacenar.existencias = existencias(paquete)
        paquetePorAlmacenar.almacenado = true
        paquetes.append(paquetePorAlmacenar)
    }
    
    func obtenerPaquete(id: Int) -> Paquete? {
        //Recorrido de paquete in paquetes
        for paquete in paquetes {
            if paquete.id == paquete.id{
                return paquete
            }
        }
        return nil
    }
}
//Pruebas unitarias
//Agregar datos de prueba
let paquete4 = PaqueteAmazon(id: 4, descripcion: "Shorts")
let paquete1 = PaqueteAmazon(id: 1, descripcion: "Zapatos")
let paquete2 = PaqueteAmazon(id: 2, descripcion: "Sandalias")
let paquete3 = PaqueteAmazon(id: 3, descripcion: "Tenis")
//Instanciamiento de clase Almacen Amazon
let almacen = AlmacenAmazon()
//mando a llamar a almacenar paquete
almacen.almacenarPaquete(paquete: paquete1) { paquete in return 10 }
almacen.almacenarPaquete(paquete: paquete2) { paquete in return 5 }
almacen.almacenarPaquete(paquete: paquete3) { paquete in return 20 }

almacen.reportarPaquetes { paquete in return "[\(paquete.id)] \(paquete.descripcion) (\(paquete.existencias)) [\(paquete.almacenado ? "ALMACENADO" : "SIN ALMACENAR")]" }
//retiro el paquete con el indice 2
almacen.retirarPaquete {
    paquete in
    if paquete.id == 2 {
        return 0
    } else {
        return paquete.existencias
    }
}
//Mando a llamar a mi reporte
almacen.reportarPaquetes { paquete in return "[\(paquete.id)] \(paquete.descripcion) (\(paquete.existencias)) [\(paquete.almacenado ? "ALMACENADO" : "SIN ALMACENAR")]" }
