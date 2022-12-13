/*
 Eduardo Batista (batista.eduardo.mat@gmail.com)
 
 Creado 12 diciembre 2022
 
 Practica 21 - Manejo de estructuras, clase y protocolos.
 
 */
import Foundation

class Cliente {
    
    let id: Int
    let nombre: String
    var activo: Bool = true
    
    init(id: Int, nombre: String){
        self.id = id
        self.nombre = nombre
    }
    
    func describir()-> String{
        return "\(self.id) \(self.nombre) \(self.activo)"
    }
}
// Clase Pago

// * Se modificó la estructura por una clase para mutabilidad de dattos
class Pago {
    
    let id: Int
    let descripcion: String
    var monto: Double
    var pagado: Bool = false
    
    init(id: Int, descripcion: String, monto: Double){
        self.id = id
        self.descripcion = descripcion
        self.monto = monto
    }
    
    func pagar(){
        self.pagado = true
    }
    
    func describir() ->String{
        let estado = pagado ? "PAGADO": "NO PAGADO"
        return "Estado: \(estado). Monto: \(self.monto). \(self.descripcion)"
    }
}

// Clase terminal retiene el arreglo de un cliente con sus pagos
class TerminalPago{
    let id: Int
    var pagos: [(cliente: Cliente, pago: Pago)]
    
    init(id: Int){
        self.id = id
        self.pagos = []
    }
    // Método agregarPago
    // Registra un cliente y su pago en arreglo
    // invoca el metodo pagar() del pago
    func agregarPago(cliente: Cliente, pago: Pago){
        // 1 Imprimimos los detalles del pago
        print("PROCESANDO PAGO PARA:")
        print("CLIENTE:\(cliente.describir())")
        print("PAGO:\(pago.describir())")
        // 2 Llamamos al método pagar() del pago
        pago.pagar()
        
        // 3 Agregramo el cliente y el pago en forma de tupla en pagos
        pagos.append((cliente: cliente, pago: pago))
    }
    
    // Método mostrarPago()
    // Imprime la listta de los pagon en esta terminal
    // Reporta el número de pagos y el total de los montos
    func mostrarPagos(){
        // 1 Reporta el numero de pagos
        print("PAGOS:\(pagos.count)")
        print("-----------------------------------")
        // 2
        for (cliente, pago) in pagos{
            print("TERMINAL: #\(self.id)")
            print("CLIENTE: \(cliente.describir())")
            print("PAGO: \(pago.descripcion)")
            print("-----------------------------------")
        }
        // Transformamos el arreglo de pagos en el arreglo de montos
        let montos = pagos.map(\.pago.monto)
        var total = 0.0
        // Calculamos el total de los montos
        for monto in montos {
            total += monto
        }
        print("TOTAL: \(total)")
    }
    
    
}
// Prueba Unitaria
// Crear dos clientes
var usuarioOxxo = Cliente(id: 1, nombre: "Eduardo")
var usuarioSeven = Cliente(id: 2, nombre: "David")
//Crear 6 pagos
var pago1 = Pago(id: 1, descripcion: "Gansito", monto: 23.5)
var pago2 = Pago(id: 2, descripcion: "Sabritas", monto: 14.00)
var pago3 = Pago(id: 3, descripcion: "Chetos", monto: 12.00)

var pago4 = Pago(id: 4, descripcion: "Jarrito", monto: 10.0)
var pago5 = Pago(id: 5, descripcion: "Galletas", monto: 9.5)
var pago6 = Pago(id: 6, descripcion: "Cafe", monto: 8.5)

// Crear una terminal
var terminal1 = TerminalPago(id: 1)

// Agregar los pagos para el cliente 1
terminal1.agregarPago(cliente: usuarioOxxo, pago: pago1)
terminal1.agregarPago(cliente: usuarioOxxo, pago: pago2)
terminal1.agregarPago(cliente: usuarioOxxo, pago: pago3)

// Agregar los pagos para el cliente 2
terminal1.agregarPago(cliente: usuarioSeven, pago: pago4)
terminal1.agregarPago(cliente: usuarioSeven, pago: pago5)
terminal1.agregarPago(cliente: usuarioSeven, pago: pago6)

// Mostrar los pagos en la terminal
terminal1.mostrarPagos()

// Creamos 2 terminales
var terminal2 = TerminalPago(id: 2)
var terminal3 = TerminalPago(id: 3)

// Cargamos la Terminal 2 con el primer Cliente y sus pagos 1, 3 y 6
terminal2.agregarPago(cliente: usuarioOxxo, pago: pago1)
terminal2.agregarPago(cliente: usuarioOxxo, pago: pago3)
terminal2.agregarPago(cliente: usuarioOxxo, pago: pago5)

// Cargamos la Terminal 3 con el primer Cliente y sus pagos 1, 3 y 6
terminal3.agregarPago(cliente: usuarioSeven, pago: pago2)
terminal3.agregarPago(cliente: usuarioSeven, pago: pago4)
terminal3.agregarPago(cliente: usuarioSeven, pago: pago6)

terminal2.mostrarPagos()
print("---------------")
terminal3.mostrarPagos()
