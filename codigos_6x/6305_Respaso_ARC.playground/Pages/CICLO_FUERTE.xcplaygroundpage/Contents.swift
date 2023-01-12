import UIKit

// FUERTE

class Persona {
    
    let nombre: String
    
    var empleo: Empleo?
    
    init(nombre: String) {
        self.nombre = nombre
        
        print("Se ha creado una persona con el nombre \(nombre)")
    }
    
    deinit {
        print("Se ha liberado a la persona \(nombre)")
    }
    
}

class Empleo {
 
    let descripcion: String
    
    var persona: Persona?
    
    init(descripcion: String) {
        self.descripcion = descripcion
        
        print("Se ha creado un empleo con el nombre: \(descripcion)")
    }
    
    deinit {
        
        print("Se ha liberado el empleo \(descripcion)")
        
    }
    
}

func test() {
    
    // ARC P+1:1
    let persona = Persona(nombre: "Tito")
    
    // ARC E+1:1
    let empleo = Empleo(descripcion: "Gerente")
    
    // ARC E+1:2
    persona.empleo = empleo // NO SE HA CREADO CICLO
    
    // ARC P+1:2
    empleo.persona = persona // SE CREÓ UN CICLO FUERTE
    
} // ARC: P-1: 1 | E-1: 1

test()
