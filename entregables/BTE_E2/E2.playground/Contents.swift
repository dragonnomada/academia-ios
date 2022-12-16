import UIKit
/*
 Eduardo Batista (batista.eduardo.mat@gmail.com)
 
 Creado 16 diciembre 2022
 
 Examen 2 - Diseño de las estructuras, enumeraciones y funciones
 
 */
protocol Paquete {
    var id: Int { get }
    var descripcion: String { get }
    var existencias: Int { get set }
    var almacenado: Bool { get set }
}

protocol Almacen {
    
    func obtenerPaquetePorId(id: Int)-> Paquete?
    
    func ingresarPaquete(paquete: Paquete, existencias: (Paquete)-> Int)
    
    func retirarPaquete(buscador: (Paquete) -> Int)
    
    func reportarPaquetes(reportador: (Paquete) -> String)
}

class PaqueteAmazon: Paquete {
    
    var id: Int
    
    var descripcion: String
    
    var existencias: Int = 0
    
    var almacenado: Bool = false
    
    init(id: Int, descripcion: String){
        self.id = id
        self.descripcion = descripcion
        self.existencias = 0
        self.almacenado = false
    }
}

class AlmacenAmazon:  Almacen {
    
    var paquetes: [Paquete] = []
    
    // Buscamos en la lista un paquete por id, utilizando for si se encuentra
    // regresamos el paquete o finalmente regresamos un nil
    func obtenerPaquetePorId(id: Int) -> Paquete? {
        for paquete in paquetes {
            if paquete.id == id {
                return paquete
            }
        }
        return nil
    }
    
    // Utilizando el paquete recibido generamos un paquete auxiliar para
    // cargalor los datos correspondientes, utilizando clausuras se calculara
    // el entero
    func ingresarPaquete(paquete: Paquete, existencias: (Paquete) -> Int) {
        var paqueteAlmacenar = paquete
        paqueteAlmacenar.existencias = existencias(paquete)
        paqueteAlmacenar.almacenado = true
        self.paquetes.append(paqueteAlmacenar)
    }
    // utilizando
    func retirarPaquete(buscador: (Paquete) -> Int) {
        for i in 0..<paquetes.count {
            paquetes[i].existencias = buscador(paquetes[i])
        }
    }
    // por cada paquete generamos un reporte predefinido por una clausura
    func reportarPaquetes(reportador: (Paquete) -> String){
        for paquete in paquetes {
            print(reportador(paquete))
        }
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


print("-")

almacen.reportarPaquetes { paquete in return "[\(paquete.id)] \(paquete.descripcion) (\(paquete.existencias)) [\(paquete.almacenado ? "ALMACENADO" : "SIN ALMACENAR")]" }
