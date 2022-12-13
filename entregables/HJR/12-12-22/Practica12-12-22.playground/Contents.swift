/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 12-12-22
 
 Practica 21 - Manejo de estructuras Clases y Protocolos
 */
import UIKit

//Estructura cliente, guarda los datos basicos de un cliente
struct Cliente {
    var id: Int = 1
    var nombre: String = ""
    var activo: Bool = true
    
    init(id: Int, nombre: String ) {
        self.id = id
        self.nombre = nombre
    }
    
    func describir ()-> String {
        return ("El cliente \(nombre), tiene el id \(id) y su estatus es: \(activo)")
    }
    
}


//Clase Pago
// * Se modifico la estructura por clase para poder tener mutabiliad
class Pago {
    var id: Int
    var descripcion: String
    var monto: Double
    var pagado: Bool = false
    
    init(id: Int, descripcion: String, monto: Double) {
        self.id = id
        self.monto = monto
        self.descripcion = descripcion
    }
    
    func pagar () {
        self.pagado = true
    }
    
    func describir () -> String {
        return ("El pago \(id), con un monto de $\(monto), \(descripcion)")
    }
}


//Clase TerminalPago Almacena un arreglo de clientes y pagos
 class TerminalPago {
     
     var id: Int
     var pagos: [(cliente: Cliente, pago: Pago)] = []
     
     init(id: Int) {
         self.id = id
     }
     
     
     //Metodo agregarPago
     //Registra un cliente y su pago en un arreglo
     // invoca el metodo pagar() del pago
     func agregarPago (cliente: Cliente, pago: Pago) {
         //1. Se imprime detalles de pago
         print("PROCESANDO PAGO PARA: \(cliente.nombre)")
         print("CLIENTE: \(cliente.describir())")
         print("PAGO: \(pago.descripcion)")
         //2. LLamamos el metodo pagar() del pago
         pago.pagar()
         //3. Agregamos el cliente y el pago en forma
         pagos.append((cliente, pago))
     }
     
     //Metodo mostarPagos()
     func mostrarPagos () {
         
         //1. Imprime el numero de pagos realizados en esta terminal
         print("PAGOS: \(pagos.count)")
         print("-----------------------------------")
         //2. Para cada pago se reporta cliente
         for (cliente, pago) in pagos {
             print("TERMINAL: \(self.id)")
             print("CLIENTE: \(cliente.describir())")
             print("PAGO: \(pago.describir())")
             print("-----------------------------------")
         }
         
         //Recuperamos el arreglo de los montos para cada pago
         var montos: [Double] = []
         
         for (_, pago) in pagos {
             //3.1 Agregamos el monto al arreglo de montos
             montos.append(pago.monto)
         }
         
         //Calculamos el toal
         var total = 0.0
         for monto in montos {
             total += monto
         }
         print("TOTAL: \(total)")
     }
 }

//Prueba unitaria 1:
//Crear 2 clinetes
var cliente1 = Cliente(id: 1, nombre: "Heber")
var cliente2 = Cliente(id: 2, nombre: "Emiliano")

//Crear 6 pagos
var pago1 = Pago(id: 1, descripcion: "Coca", monto: 17.5)
var pago2 = Pago(id: 2, descripcion: "Cigarros", monto: 10.5)
var pago3 = Pago(id: 3, descripcion: "Agua", monto: 5.0)
var pago4 = Pago(id: 4, descripcion: "Papas", monto: 16.3)
var pago5 = Pago(id: 5, descripcion: "GAlletas", monto: 13.4)
var pago6 = Pago(id: 6, descripcion: "Tostadas", monto: 12.0)

//Crear una termianal
var terminal1 = TerminalPago(id: 1)

//Crear pagos para cliente1
terminal1.agregarPago(cliente: cliente1, pago: pago1)
terminal1.agregarPago(cliente: cliente1, pago: pago2)
terminal1.agregarPago(cliente: cliente1, pago: pago3)

//Crear pagos para cliente2
terminal1.agregarPago(cliente: cliente2, pago: pago4)
terminal1.agregarPago(cliente: cliente2, pago: pago4)
terminal1.agregarPago(cliente: cliente2, pago: pago4)

//Muestra los pagos en la terminal
terminal1.mostrarPagos()

var terminal2 = TerminalPago(id: 2)
var terminal3 = TerminalPago(id: 3)







 
 
