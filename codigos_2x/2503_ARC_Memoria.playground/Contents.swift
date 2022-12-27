import UIKit

// Módulo 19. Gestión de la memoria Cómo funciona ARC
      
/*
 
 Swift es un lenguaje poderoso en el manejo de memoria
 y a diferencia de otros lenguajes orientados a objetos
 dispone de un `deconstructor` llamado el `deinicializador` (`deinit`)
 el deinicializador tomará una clausura que será llamada automáticamente
 cuándo una instancia pierda todas sus referencias.
 
 El objetivo de la deinicialización será liberar recursos intensivos
 que se hayan generado durante el ciclo de vida de la instancia.
 
 Por ejemplo, liberarar arreglos de otras instancias o vaciar recursos
 sobre todo cuándo creemos hilos que no se liberen automáticamente.
 
 Generalmente no tenemos que preocuparnos de la liberación automática
 pero existen casos dónde se creará un ciclo fuerte de referencias
 entre clases (cuándo las referencias son recursivas). Y este efecto
 impedirá que las instancias sean liberadas automáticamente, porque
 una instancia tendrá una referencia a la otra y la otra retendrá una
 referencia a la otra.
 
 Esto significa que cuándo detectemos un ciclo fuerte, debemos evitarlo.
 
 Existen dos estrategias para evitar los ciclos fuertes y establecer
 un mecanismo que indique una relación de debilidad o impropiedad.
 
 * Referencias impropias (enlaces flojos `lazy`)
 * Referencias débiles (enlaces débiles `weak`)
 
 */

// ARC (Automatic Reference Count)

/*
 
 Al crear una instancia y almacenarla en una variable la instancia tendrá una referencia
 al eliminar la variable (mediante el fin de su clausura o volviendo la variable a nil)
 entonces la instancia perderá una referencia.
 
 Al compiar una variable en otra, la instancia adquiere una nueva referencia
 y Swift mantiene de forma oculta un conteo a todas las referencias que hay sobre
 una instancia. Esto significa que Swift cuenta automáticamente las referencias a una instancia.
 
 Si una instancia pierde todas sus referencias (el conteo llega a 0), entonces
 se mandará a llamar al deinicializador en ese momento y se liberarán
 todos los recursos de ese instancia.
 
 */

class A {
    
    let nombre: String
    
    init(nombre: String) {
        self.nombre = nombre
        print("Se ha creado un objeto de A: \(nombre)")
    }
    
    deinit {
        print("Se ha liberado un objeto A: \(nombre)")
    }
    
}

var a: A? = nil

let construirInstanciasA = {
    // REFERENCIA Rx001 [0]
    let a1 = A(nombre: "A1") // Rx001 [+1 -> 1]
    // REFERENCIA Rx002 [0]
    let a2 = A(nombre: "A2") // Rx002 [+1 -> 1]
    
    a = a1 // Rx001 [+1 -> 2]
} // Rx001 [-1 -> 1] Rx002 [-1 -> 0]
// Rx002 es liberada por alcanzar 0 referencias

construirInstanciasA()

print("Todo lo que haya ocurrido")

a = nil // Rx001 [-1 -> 0]
// Rx001 es liberada por alcanzar 0 referencias

// Fuertes ciclos de referencia

/*
 
 Cuándo una clase refiere a una instancia de otra clase y viceversa
 se crea una relación cíclica (recursiva) lo cual genera un ciclo fuerte
 de referencia.
 
 Esto significa que ninguna instancia podrá liberar a la otra, ni a sí misma
 porque el conteo nunca llegará a 0, siempre habrá alguien referido al mismo tiempo
 
 */

class Direccion {
    let calle: String
    
    var ubicacion: Ubicacion? = nil
    
    init(calle: String) {
        self.calle = calle
        print("Una dirección se ha creado para la calle: \(calle)")
    }
    
    deinit {
        print("Una dirección ha sido liberada para la calle: \(calle)")
    }
}

class Ubicacion {
    let latitud: Double
    let longitud: Double
    
    var direccion: Direccion? = nil
    
    init(latitud: Double, longitud: Double) {
        self.latitud = latitud
        self.longitud = longitud
        
        print("Una ubicación ha sido creada para: (\(latitud), \(longitud))")
    }
    
    deinit {
        print("Una ubicación ha sido liberada para: (\(latitud), \(longitud))")
    }
}

let crearDireccionUbicacion = {
    var direccion1 = Direccion(calle: "Av. Siempre viva 123") // Direccionx001:1

    var ubicacion1 = Ubicacion(latitud: 123.456, longitud: 789.654) // Ubicacionx001:1

    // Hasta aquí las instancias `direccion1` y `ubicacion1` son independientes

    // Pero si actualizamos las referencias internas, crearemos una recursivad entre instancias

    // La `direccion1` guarda una referencia más a la `ubicacion1`
    direccion1.ubicacion = ubicacion1 // Ubicacionx001:2
    // La `ubicacion1` guarda una referencia más a la `direccion1`
    ubicacion1.direccion = direccion1 // Direccionx001:2
} // Teóricamente las instancias deberían llegar a 0 al finalizar la clausura
// pero no es cierto, porque cada instancia tiene 2 referencias en forma de ciclo fuerte
// Direccionx001:1
// Ubicacionx001:1

crearDireccionUbicacion() // Al finalizar la clausura quedarón atrapadas referencias
// cíclicas y se impidió la liberación de ambas

// Referencias sin propietario

/*
 
 El problema de las refencias recursivas o cíclicas es el efecto que ninguna querrá liberar
 a la otra porque entre ellas se siguien utilizando (aunque ya no lo hagan).
 
 Entonces debemos determinar sobre alguna de las dos que la propiedad referenciada
 no dependende de esa clase y puede asumir que es impropia (no tiene propietario)
 y su ciclo de vida será superior.
 
 A esto le llamamos una referencia floja.
 
 Ocurre una referencia floja cuándo la CLASE1 tiene una referencia a la CLASE2
 y hace una suposición que la CLASE2 tendrá mayor vida que la CLASE1.
 
 Es decir, la CLASE1 se asume más desechable o con menor vida que la CLASE2
 esto es como si la CLASE1 se asumierá más débil que la CLASE2.
 
 Esta debilidad le permitirá a la CLASE1 liberarse sin importar si se libera la CLASE2.
 
 */

class Gansito {
    
    let nombre: String
    
    // Gansito supone que su dueño es fuerte
    // el se asume flojo/débil
    // El dueño es flojo para mantener vivo al gansito
    lazy var dueño: DueñoGansito? = nil
    
    init(nombre: String) {
        self.nombre = nombre
        print("Se ha creado un gansito llamado: \(nombre)")
    }
    
    deinit {
        print("Se ha liberado un gansito llamado: \(nombre) [Recuerdame]")
    }
    
}

class DueñoGansito {
    
    let nombre: String
    
    var gansito: Gansito? = nil
    
    init(nombre: String) {
        self.nombre = nombre
        
        print("El dueño del gansito se ha creado llamado: \(nombre)")
    }
    
    deinit {
        print("El dueño del gansito fue liberado: \(nombre)")
    }
    
}

let dueñoMarinel = DueñoGansito(nombre: "Marinel") // DueñoGansitox001:1

let adoptarGansito = {
    let gansitoDonaldo = Gansito(nombre: "donaldo") // Gansitox001:1
    
    gansitoDonaldo.dueño = dueñoMarinel // DueñoGansitox001:2
    
    dueñoMarinel.gansito = gansitoDonaldo // Gansitox001:2
} // Teoricamente ninguna instancia será liberada porque tienen un ciclo de referencia
// pero no es cierto, el gansito al asumirse débil podrá liberado terminando la clausura
// Como gansitoDonaldo no se ocupa más
// se descuenta la referencia en cuánto el dueño lo olvide

adoptarGansito()

// El dueño asume al gansito débil y lo olvida
dueñoMarinel.gansito = nil // El gansito ha sido liberado

/*
 
 Conclusiones:
 
 * El gansito al perder su dueño es liberado inmediatamente
 * Cuándo la instancia fuerte (marcada como lazy) libera a la instancia débil
   la instancia débil es liberada sin importar si la instancia fuerte se libera o no

 */

let crearDueñoConGansito = {
    
    let dueñoGelipe = DueñoGansito(nombre: "Gelipe")
    
    let gansitoPepe = Gansito(nombre: "pepe")
    
    dueñoGelipe.gansito = gansitoPepe
    gansitoPepe.dueño = dueñoGelipe
    
    dueñoGelipe.gansito = nil // al morir el dueño arrastará al gansito
    
    print("Fin de la clausura")
    
} // Teoricamente ninguna instancia dejaría liberar a la otra y quedarían atrapados en memoria
// pero no es ciero, al asumirse gansito débil, dejará que el dueño lo libere
// y también el dueño será liberado porque ya no tienen más gansitos ni nada que hacer

crearDueñoConGansito()

// Referencias débiles

// * También conocido como liberación automática

class Persona {
    
    let nombre: String
    
    weak var perro: Perro? = nil
    
    init(nombre: String) {
        self.nombre = nombre
        print("Se ha creado una persona llamada: \(nombre)")
    }
    
    deinit {
        print("Se ha liberado una persona llamada: \(nombre)")
    }
    
}

class Perro {
    
    let nombre: String
    
    var persona: Persona? = nil
    
    init(nombre: String) {
        self.nombre = nombre
        print("Se ha creado un perro llamado: \(nombre)")
    }
    
    deinit {
        print("Se ha liberado un perro llamado: \(nombre)")
    }
    
}

let personaAdoptaPerro = {
    
    let personaLucho = Persona(nombre: "Lucho")
    
    let perroFirulais = Perro(nombre: "firulais")
    
    personaLucho.perro = perroFirulais
    
    perroFirulais.persona = personaLucho
    
} // Teoricamente ninguno se libera
// pero no es cierto, el perro se libera solo
// el dueño se libera solo

personaAdoptaPerro()

/*
 
 La buena práctica es establecer de tipo weak todas las referencias hacía otras
 instancias dentro de una clase.
 
 Es muy común ver que siempre se marca weak en cualquier referencia opcional.
 
 Exista o no el ciclo, siempre marcaremos la referencia a una clase
 dentro de otra clase como `weak`
 
 */
