import UIKit

class Foo {
    var a: Int = {
        return Int.random(in: 1...10)
    }()
    
    // Rápido quiero el valor de b
    // para <<crear>> la instancia
    var b: String = {
        Thread.sleep(forTimeInterval: 10)
        return "Hola [(self.a)] \(Date.now)"
    }()
}

print(Date.now)

let foo = Foo()

print(foo.a)
print(foo.b)

class Bar {
    
    var a: Int = {
        return Int.random(in: 1...10)
    }()
    
    // Tranquilo, cuándo alguien llame
    // a `b` en ese momento calcula
    // su valor inicial
    lazy var b: String = {
        Thread.sleep(forTimeInterval: 10)
        return "Hola [\(self.a)] \(Date.now)"
    }()
    
}

print(Date.now)

let bar = Bar()

print(bar.a)
//print(bar.b)

print("LISTO")

// LAZY

class Persona {
    
    var nombre: String
    
    var empleo: Empleo?
    
    init() {
        self.nombre = "Anónimo"
        
        print("Se ha creado una persona con el nombre \(nombre)")
    }
    
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
    
    lazy var persona: Persona = {
        let persona = Persona()
        // Retardar la configuración:
        // Ej. Llamar a un API y configurar la persona
        // Ej. Sacar el nombre de un TextField
        // Ej. Sacar la persona del CoreData
        // Ej. Sacar los datos de la persona del Login
        
        persona.empleo = self
        
        // TARDAMOS 5 segundos en calcular
        // la persona
        Thread.sleep(forTimeInterval: 5)
        
        persona.nombre = "Pepe"
        
        return persona
    }()
    
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
    
    print(persona.nombre)
    
    // ARC E+1:1
    let empleo = Empleo(descripcion: "Gerente")
    
    print(empleo.descripcion)
    
    //print(empleo.persona.nombre)
    //print(empleo.persona.nombre)
    
    // ARC E+1:2
    //persona.empleo = empleo // NO SE HA CREADO CICLO
    
    // ARC P+1:2
    //empleo.persona = persona // SE CREÓ UN CICLO FUERTE
    
} // ARC: P-1: 0 | E-1: 0

print(Date.now)

test()

print(Date.now)
