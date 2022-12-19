import UIKit

/// # Patrones de Diseño

///
/// Los patrones de diseño nos permiten generar buenas prácticas para la contrucción en general
/// de objetos e instancias.
///
/// Las dos principales filosofias detrás del diseño patrones son:
///
/// * Reutilización de código
/// * Flexibilidad
///

/// # Patrones de diseño creacionales

///
/// Nos permiten crear objetos mediante una forma más personalizada y formal.
///
/// Los principales patrones de diseño son:
///
/// - The abstract factory pattern: Es una interfaz para generar objetos relacionados sin especificar un tipo concreto
/// - The builder pattern: Separa la contrucción de objetos complejos de su representación, así el mismo proceso puede ser utilizado para crear tipos similares
/// - The factory method pattern: Crea objetos sin exponer la lógica subyacente de como el objeto ha sido creado
/// - The prototype pattern: Crea un objeto clonando uno existente
/// - The singleton pattern: Administra una única instancia en todo el ciclo de vida de la aplicación
///

/// ## El patrón singleton
///
/// Administra una instancia durante todo el ciclo de vida de una aplicación.
///
/// Es útil para administrar un  único servicio utilizado durante todo el programa.
///
/// Por ejemplo, un repositorio de productos, un administrador del usuario que ha iniciado sesión o la configuración de la app (colores, tipos, etc).
///

class AppUserService {
    
    /// Creamos una instancia estática que será usada durante todo el ciclo de vida de la aplicación
    /// En cualquier lugar del código podremos usar el AppUserService, para la instancia shared
    static let shared = AppUserService()
    
    var username: String? = nil
    var password: String? = nil
    
    var isLogged: Bool { username != nil && password != nil }
    
    func signIn(username: String, password: String) -> Bool {
        // TODO: Validar username y password
        self.username = username
        self.password = password
        return true
    }
    
    func signOut() -> Bool {
        // TODO: Cerrar la sesión para el username y password
        self.username = nil
        self.password = nil
        return true
    }
    
}

AppUserService.shared.signIn(username: "pepe", password: "pepe123")

if AppUserService.shared.isLogged {
    print("El usuario ha iniciado sesión")
}

// ...
AppUserService.shared.signOut()

if AppUserService.shared.isLogged {
    print("El usuario ha iniciado sesión")
} else {
    print("El usuario necesita iniciar sesión")
}

/// ## El patrón del constructor
///
/// Consiste en que existen objetos con una gran cantidad de parámetros configurables
/// y deseamos crear un constructor que separe en nuevos tipos las construcciones personalizadas,
/// así nuestra clase base podrá recibir un configurador o un constructor que le dé toda la información.
///
/// Por ejemplo, imagina un pedido de algún alimento para un restaurante que tiene muchas
/// posibles configuraciones. Como una hamburguesa que tiene todos los posibles ingredientes:
///
/// > Lista de ingredientes posibles para una hamburguesa
///
/// Ingredientes | Configuraciones que lo contienen
/// --- | ---
/// Carne de Res | `BBQ`, `Chesse Supreme`, `Big Pound`, `Texas BBQ`
/// Chicken Tender | `BBQ Chicken`, `Chesse Supreme Chicken`, `Little Chicken`
/// Queso amarillo | `Chesse Supreme`, `Chess Supreme Chicken`
/// `...` | `...`
///

enum GradoPicante {
    case normal
    case picosa
    case muyPicosa
}

enum CarneSala {
    case bbq (GradoPicante)
    case chipotle
    case mangoHabanero(GradoPicante)
    case tajin(String)
    case cajun
    case teriyaki
}

/**
 Retiene los ingredientes de una hamburguesa genérica
 */
struct Hamburguesa {
    let carneRes: Bool
    let carnePollo: Bool
    let carneSalsa: CarneSala
    let lechuga: Bool
    let jitomate: Bool
    let quesoAmarillo: Bool
    let quesoManchego: Bool
    let pepinillos: Bool
    let dobleCarne: Bool
    let tripleCarne: Bool
    var costo: Double {
        var total = 0.0
        if carneRes { total += 30 }
        if carnePollo { total += 20 }
        if dobleCarne { total += 15 }
        if tripleCarne { total += 30 }
        if quesoAmarillo { total += 5 }
        if quesoManchego { total += 7 }
        switch carneSalsa {
        case .cajun, .chipotle, .tajin(_), .teriyaki:
            total += 0.0
        case .bbq(let grado):
            if grado == .picosa || grado == .muyPicosa {
                total += 5
            }
        case .mangoHabanero(let grado):
            if grado == .picosa || grado == .muyPicosa {
                total += 8
            }
        }
        return total
    }
}

// Crear una hamburguesa
let cheeseSupreme = Hamburguesa(carneRes: true, carnePollo: false, carneSalsa: .mangoHabanero(.picosa), lechuga: true, jitomate: true, quesoAmarillo: true, quesoManchego: true, pepinillos: true, dobleCarne: false, tripleCarne: true)

///
/// El patrón de diseño contructor (builder-pattern)
/// Nos dice que creemos un protocolo que estandarice las opciones para que nuestra
/// clase se construya o soporte construirse con las configuraciones del constructor
///

// 1. Construir un protocolo de soporte a la estructura original
// para facilitar la construcción de objetos
protocol HamburguesaBuilder {
    var carneRes: Bool { get }
    var carnePollo: Bool { get }
    var carneSalsa: CarneSala { get }
    var lechuga: Bool { get }
    var jitomate: Bool { get }
    var quesoAmarillo: Bool { get }
    var quesoManchego: Bool { get }
    var pepinillos: Bool { get }
    var dobleCarne: Bool { get }
    var tripleCarne: Bool { get }
}

enum HamburguesaError: Error {
    case builderError
}

// 2. Implementamos la el protocolo a través de nuevas estructuras
// con configuraciones por defecto que tomarán los nuevos objetos
struct HamburguesaCheeseSupremeBuilder: HamburguesaBuilder {
    var carneRes: Bool = true
    var carnePollo: Bool = false
    var carneSalsa: CarneSala = .mangoHabanero(.picosa)
    var lechuga: Bool = true
    var jitomate: Bool = true
    var quesoAmarillo: Bool = true
    var quesoManchego: Bool = true
    var pepinillos: Bool = true
    var dobleCarne: Bool = false
    var tripleCarne: Bool = true
    init(salsa carneSalsa: CarneSala) throws {
        switch carneSalsa {
        case .cajun, .chipotle, .tajin(_), .teriyaki:
            throw HamburguesaError.builderError
        case .bbq(_), .mangoHabanero(_):
            self.carneSalsa = carneSalsa
        }
    }
}

struct HamburguesaRoyalCheeseBBQBuilder: HamburguesaBuilder {
    var carneRes: Bool = true
    var carnePollo: Bool = false
    var carneSalsa: CarneSala = .bbq(.picosa)
    var lechuga: Bool = true
    var jitomate: Bool = true
    var quesoAmarillo: Bool = true
    var quesoManchego: Bool = true
    var pepinillos: Bool = false
    var dobleCarne: Bool = true
    var tripleCarne: Bool = false
}

// Extender la posibilidad de que una hamburguesa se cree a partir
// de nuestro protocolo y no de los parámetros (extender el `init`)
extension Hamburguesa {
    init(builder: HamburguesaBuilder) {
        self.carneRes = builder.carneRes
        self.carnePollo = builder.carnePollo
        self.carneSalsa = builder.carneSalsa
        self.lechuga = builder.lechuga
        self.jitomate = builder.jitomate
        self.quesoAmarillo = builder.quesoAmarillo
        self.quesoManchego = builder.quesoManchego
        self.pepinillos = builder.pepinillos
        self.dobleCarne = builder.dobleCarne
        self.tripleCarne = builder.tripleCarne
    }
}

// Finalmente si deseamos crear una hamburguesa
// la clase podrá tomar un constructor y recuperar los datos
// de esa hambuguesa
let royalCheeseBbq = Hamburguesa(builder: HamburguesaRoyalCheeseBBQBuilder())

print(royalCheeseBbq.costo)

if let supremeCheeseBbq = try? Hamburguesa(builder: HamburguesaCheeseSupremeBuilder(salsa: .cajun)) {
    print("Se pudo crear la hamburguesa")
    print(supremeCheeseBbq)
} else {
    print("No se puede crear la hamburguesa con salsa cajun")
}

/// # Patrones de diseño estructurales

/// ## El patrón bridge
///
/// Un puenteo entre objetos permite administrar múltiples objetos distintos para hacer una operación
/// común.
///
/// Por ejemplo, tenemos un usuario, un producto y un almacén, entonces el usuario
/// quiere almacer el producto en el almacén. Entonces podemos crear un puente
/// que nos facilite las operaciones.
///
/// **Nota:** Esta no es una operación que le deba pertenecer al usuario, al producto
/// o al almacén, ya que los tres están igual de involucrados.
///

struct Usuario {
    let id: Int
    let nombre: String
    let contraseña: String
}

struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
    var almacen: Almacen? = nil
    var usuario: Usuario? = nil
}

class Almacen {
    var productos: [Producto] = []
    func registrarProducto(_ producto: Producto) {
        productos.append(producto)
    }
}

let usuarioPepe = Usuario(id: 1, nombre: "pepe", contraseña: "pepe123")
var productoCoca = Producto(id: 1, nombre: "Coca Cola", precio: 17.5)
let almacenAmazon = Almacen()

// Código peligroso:
// * Si el programador olvida establecer el almacén y usuario
//   previamente a registrarlo, así quedará registrado
//   entonces, podríamos tener pérdida de información
productoCoca.almacen = almacenAmazon
productoCoca.usuario = usuarioPepe
almacenAmazon.registrarProducto(productoCoca)

class AlmacenarBridge {
    static let shared = AlmacenarBridge()
    func almacenar(almacen: Almacen, usuario: Usuario, producto: Producto) {
        var productoCopia = producto
        productoCopia.almacen = almacen
        productoCopia.usuario = usuario
        almacen.registrarProducto(productoCopia)
    }
}

AlmacenarBridge.shared.almacenar(almacen: almacenAmazon, usuario: usuarioPepe, producto: productoCoca)

/// ## El patrón de la facade
///
/// El patrón de fachada establece una operación compleja con parámetros comunes a distintos objetos
/// Es decir, podemos reutilizar una misma fachada en diferentes objetos con diferente naturaleza.
///
/// Por ejemplo, la reserversación de un hotel tiene como fachada un usuario, una fecha de ingreso
/// y una fecha de salida. Un viaje en avión tiene como fachada un usuario, una fecha de despegue
/// y una fecha de llegada. Un viaje de turista tiene como fachada un usuario, una fecha de inicio
/// y una fecha de fin.
///
/// Entonces, podríamos crear una misma fachada para todos los objetos que involucran una operación
/// de itinerario para nuestros usuarios. Por ejemplo, el usuario podría hacer la reservación automática
/// del hotel un día antes de la fecha de inicio, podría llegar al hotel e ingresar en la fecha de inicio,
/// tomar el viaje de turista un día después de la fecha de inicio, retirarse del hotel un día antes de
/// la fecha de fin y tomar el vuelo en la fecha de salida.
///

class Hotel {
    func reservar(usuario: Usuario, ingreso: Date, retiro: Date) {
        // TODO: La lógica de la reservación
    }
}

class Vuelo {
    func comprar(usuario: Usuario, salida: Date, regreso: Date) {
        // TODO: La lógica del vuelo ida y vuelta
    }
}

class Turibus {
    func tomar(usuario: Usuario, partida: Date, vuelta: Date) {
        // TODO: La lógica del viaje de turismo
    }
}

class TuristaReservation {
    
    var hotel: Hotel?
    var vuelo: Vuelo?
    var turibus: Turibus?
    
    func reservar(usuario: Usuario, inicio: Date, fin: Date) -> Bool {
        // Buscar mejor hotel
        hotel = Hotel()
        // Buscar mejor vuelo
        vuelo = Vuelo()
        // Buscar mejor turibus
        turibus = Turibus()
        
        var ingresoHotel = inicio
        ingresoHotel.addingTimeInterval(60 * 60 * 6)
        var salidaHotel = fin
        salidaHotel.addingTimeInterval(-60 * 60 * 6)
        
        hotel?.reservar(usuario: usuario, ingreso: ingresoHotel, retiro: salidaHotel)
        
        var salidaVuelo = inicio
        salidaVuelo.addingTimeInterval(-60 * 60 * 3)
        var regresoVuelo = fin
        regresoVuelo.addingTimeInterval(+60 * 60 * 3)
        
        vuelo?.comprar(usuario: usuario, salida: salidaVuelo, regreso: regresoVuelo)
        
        var salidaTuribus = inicio
        salidaTuribus.addingTimeInterval(-60 * 60 * 1)
        var regresoTuribus = fin
        regresoTuribus.addingTimeInterval(+60 * 60 * 1)
        
        turibus?.tomar(usuario: usuario, partida: salidaTuribus, vuelta: regresoTuribus)
        
        return true
    }
    
}

var turistaReservation = TuristaReservation()

turistaReservation.reservar(usuario: usuarioPepe, inicio: Date(), fin: Date())

print(turistaReservation.hotel!)

/// ## El patrón proxy
///
/// Soluciona el problema de  no tener un tipo genérico para las clases que ya están construidas
///
/// Por ejemplo, tenemos que tomar registros de valoraciones para viajes en nuestra app.
///
///

struct Viaje {
    let id: Int
    let conductor: Usuario
    let pasajero: Usuario
    let valoracion: Double
}

class HistoriaViaje {
    var viajes: [Viaje] = []
    func agregarHistoriaViaje(conductor: Usuario, pasajero: Usuario, valoracion: Double) {
        viajes.append(Viaje(id: viajes.count, conductor: conductor, pasajero: pasajero, valoracion: valoracion))
    }
}

enum Valoracion: Double {
    case pesimo = 1.0
    case regular = 2.0
    case bueno = 3.5
    case excelente = 5.0
}

class HistoriaProxy {
    var historiaViaje = HistoriaViaje()
    let usuario: Usuario
    
    init(usuario: Usuario) {
        self.usuario = usuario
    }
    
    func agregarHistoriaViaje(conductor: Usuario, valoracion: Valoracion) -> Bool {
        // TODO: Validar quer el usuario sea un conductor
        // TODO: Actualizar la valoración promedio del conductor
        historiaViaje.agregarHistoriaViaje(conductor: conductor, pasajero: usuario, valoracion: valoracion.rawValue)
        return true
    }
}

let historiasViajes = HistoriaViaje()

historiasViajes.agregarHistoriaViaje(conductor: usuarioPepe, pasajero: Usuario(id: 34, nombre: "José Luz", contraseña: "lucho123"), valoracion: 10.0)

let historiasProxy = HistoriaProxy(usuario: usuarioPepe)

historiasProxy.agregarHistoriaViaje(conductor: Usuario(id: 34, nombre: "José Luz", contraseña: "lucho123"), valoracion: .bueno)
historiasProxy.agregarHistoriaViaje(conductor: Usuario(id: 23, nombre: "Juan Manuel", contraseña: "manolo123"), valoracion: .pesimo)
