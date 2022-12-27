import UIKit

protocol LadradorProtocol {
    
    var ladridos: [String] { get }
    
    func ladrar()
    
}

protocol CaminadorProtocol {
    
    var pasos: Int { get }
    
    func caminar()
    
}

protocol ReportadorLadridosProtocol {
    
    func reportarLadridos(ladrador: LadradorProtocol)
    
}

class Perro: LadradorProtocol, CaminadorProtocol {
    
    let nombre: String
    let raza: String
    
    init(nombre: String, raza: String) {
        self.nombre = nombre
        self.raza = raza
    }
    
    var ladridos: [String] = []
    
    func ladrar() {
        ladridos.append("[Raza \(self.raza)] (\(self.nombre)) woof woof \(ladridos.count)")
    }
    
    var pasos: Int = 0
    
    func caminar() {
        pasos += 10
    }
    
}

class PerroReportador: ReportadorLadridosProtocol {
    
    func reportarLadridos(ladrador: LadradorProtocol) {
        
        for ladrido in ladrador.ladridos {
            print(ladrido)
        }
        
    }
    
}

var perro1 = Perro(nombre: "Bombón", raza: "Frech Pudle")

perro1.ladrar()
perro1.ladrar()
perro1.ladrar()

perro1.caminar()
perro1.caminar()

var perro2 = Perro(nombre: "Choclo", raza: "Callejero")

perro2.ladrar()
perro2.ladrar()

perro2.caminar()
perro2.caminar()
perro2.caminar()

var reportadorPerros1 = PerroReportador()

reportadorPerros1.reportarLadridos(ladrador: perro1)
reportadorPerros1.reportarLadridos(ladrador: perro2)
