import UIKit

// Módulo 18. Tipos de valores personalizados

/*
 
 Cada componente en swift genera un tipo, por ejemplo, los tipos principales son:
 
 Primitivos  (Int...    -> TIPO VALOR)
 Enumeración (Enum      -> TIPO VALOR)
 Estructura  (Struct    -> TIPO VALOR)
 Clase       (Class     -> TIPO REFERENCIA)
 Protocolo   (Protocol  -> TIPO REFERENCIA*)
 Functión    (Function  -> TIPO REFERENCIA*)
 Clausura    (Clausure  -> TIPO REFERENCIA*)
 Opcionales  (Optional  -> TIPO MIXTO)

 */

// Tipos de valor y tipos de referencia

/*
 
 Los valores almacenados en variables serán copiados a otras variables
 en dos modalidades:
 
 TIPO VALOR: Se crea una copia del valor o de todos los valores
 TIPO REFERENCIA: Se crea una copia a la referencia (instancia, enlance)
 
 */

var a = 123   // Entero TIPO VALOR
var b = a     // Copio el valor de `a` y (no hay referencia)

b = 456

print(a) // 123
print(b) // 456

enum FiguraCarta {
    case picas, diamantes, corazones, treboles
}

var figura1 = FiguraCarta.picas // Enumeración: TIPO VALOR
var figura2 = figura1 // Se crea copia de valores (`figura1` y `figura2` son independientes)

figura2 = .diamantes

print(figura1) // .picas
print(figura2) // .diamantes

struct Mensaje {
    let id: Int
    let contenido: String
    var creado: Date?
}

var mensaje1 = Mensaje(id: 1, contenido: "Hola :)", creado: nil) // Estructura TIPO VALOR
var mensaje2 = mensaje1 // Se crea copia de valores (`mensaje1` y `mensaje2` son independientes)

mensaje2.creado = Date(timeIntervalSince1970: 1_000_000)

print(mensaje1)
print(mensaje2)

// Estructuras >>> Entidad -> Un conjunto de datos almacenados/retenidos
// * Almacena la información en forma estructurada (evita uso de tuplas y formaliza el sistema)
struct Usuario {
    let id: Int
    var nombre: String?
    let email: String
    var contraseña: String
    var activo: Bool
}

// Clases >>> Controlador -> Controlan entidades y estados
// * Toma otras entidades o listas de entidades para aplicar operaciones de largo alcance
class UsuarioSesion {
    
    var usuarioSesion: Usuario? = nil
    var sesionIniciada: Bool { get { usuarioSesion != nil && usuarioSesion!.activo } }
    var desc: String { get { "\(usuarioSesion) [SESIÓN INICIADA: \(sesionIniciada)]" } }
    
    func iniciaSesion(email: String, contraseña: String) {
        // TODO: API para iniciar sesión
        
        // ...
        
        usuarioSesion = Usuario(id: 123, email: email, contraseña: contraseña, activo: true)
    }
    
    func cerrarSesion() {
        usuarioSesion = nil
    }
    
}

// Las instancias residen en un oculto y las variables retienen una referencia a esa misma instancia
var usuarioSesionApp = UsuarioSesion() // Clase TIPO REFERENCIA
var usuarioSesionPage = usuarioSesionApp // Crea una copia a la misma referencia que `usuarioSesionApp`
// * Lo que le ocurra a la referencia a través de `usuarioSesionApp` o `usuarioSesionPage`
//   afectará a la una y a la otra

print(usuarioSesionApp.desc)
print(usuarioSesionPage.desc)

usuarioSesionApp.iniciaSesion(email: "pepe@gmail.com", contraseña: "pepe123")

print(usuarioSesionApp.desc)
print(usuarioSesionPage.desc)

usuarioSesionPage.cerrarSesion()

print(usuarioSesionApp.desc)
print(usuarioSesionPage.desc)

// Clausuaras >>> TIPO REFERENCIA

var bloque1 = { // Clausura TIPO REFERENCIA con FIRMA: () -> Void
    print("Hola desde el bloque 1")
}
var bloque2 = bloque1 // Se crea una referencia a la misma clausura

bloque1()
bloque2()

// Tipos de datos recursivos para tipos de referencia

/*
 
 Los tipos pueden ser anidados unos dentro de otros creando recursividad de tipos
 
 */

class X {
    var y: Y?
}

class Y {
    var x: X?
}

// Herencia para tipos de referencia

class A {
    var desc: String { "Hola soy A" }
}

class B: A {
    override var desc: String { "Hola soy B" }
    
    func goo() {
        print("Goo desde B")
    }
}

var a1 : A = A()
var b1 : A = B()

print(type(of: a1))
print(type(of: b1))

//a1.goo()
//b1.goo()

// Dispatch dinámico

protocol Despachable {
    
    func ejecutar() -> Void
    
}

class DespachadorPersonalizado<T: Despachable> {
    
    var despachables: [T] = []
    
    func agregarDespachable(_ despachable: T) {
        despachables.append(despachable)
    }
    
    func despachar(_ despachable: T) {
        despachable.ejecutar()
    }
    
    func despacharTodos() {
        while despachables.count > 0 {
            let despachable = despachables.removeFirst()
            despachar(despachable)
        }
    }
    
}

class Boton: Despachable {
    
    let titulo: String
    
    init(titulo: String) {
        self.titulo = titulo
    }
    
    func ejecutar() {
        print("El botón ha sido pulsado")
    }
    
}

let despachador = DespachadorPersonalizado<Boton>()

despachador.agregarDespachable(Boton(titulo: "Pulsame"))
despachador.agregarDespachable(Boton(titulo: "Dale clic"))
despachador.agregarDespachable(Boton(titulo: "Enviar Formulario"))
despachador.agregarDespachable(Boton(titulo: "Cancelar"))

despachador.despacharTodos()

// Implementación del protocolo Equatable

// Equatable inferido
struct Producto: Equatable {
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
}

struct Color {
    let r: Int
    let g: Int
    let b: Int
}

// Equatable detecta que algún valor no es Equatable,
// no puede inferir todas las igualdades de valores
// y Equatable debe ser explícito
struct Persona: Equatable {
    let id: Int
    let nombre: String
    var creado: Date?
    var activo: Bool { get { creado != nil } }
    var sesiones: [Date]
    var color: Color? // SI COLOR ES EQUATABLE SIGUE LA INFERENCIA
    
    static func == (lhs: Persona, rhs: Persona) -> Bool {
        // TODO: Implementar si dos personas son igual
        return false
    }
}

let persona1 = Persona(id: 1, nombre: "Pepe", sesiones: [])
let persona2 = Persona(id: 1, nombre: "Pepe", sesiones: [])

print(persona1 == persona2)

