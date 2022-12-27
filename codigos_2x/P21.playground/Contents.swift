/*
 
 Alan Badillo Salas (dragonnomada123@gmail.com)
 
 Creado el 12 de diciembre de 2022
 
 Práctica 21 - Manejo de estructuras, clases y protocolos
 
 */

import UIKit

// Estructura Cliente - Retiene los datos básicos de un cliente
struct Cliente {
    
    let id: Int
    let nombre: String
    let activo: Bool = true
    
    init(id: Int, nombre: String) {
        self.id = id
        self.nombre = nombre
    }
    
    func describir() -> String {
        return "\(self.id) \(self.nombre) [ACTIVO: \(self.activo)]"
    }
    
}

// Clase Pago - Captura los datos básicos de un pago
// * Se modificó la estructura por clase para permitir mutabilidad
class Pago {
    let id: Int
    let descripcion: String
    let monto: Double
    var pagado: Bool = false
    
    init(id: Int, descripcion: String, monto: Double) {
        self.id = id
        self.descripcion = descripcion
        self.monto = monto
    }
    
    func pagar() {
        self.pagado = true
    }
    
    func describir() -> String {
        return "\(self.id) \(self.descripcion) $\(self.monto) [PAGADO: \(self.pagado)]"
    }
    
}

// Clase TerminalPago - Retenie un arreglo de clientes y pagos
class TerminalPago {
    let id: Int
    var pagos: [(cliente: Cliente, pago: Pago)] = []
    
    init(id: Int) {
        self.id = id
    }
    
    // Método agregarPago(cliente: Cliente, pago: Pago)
    // Registra un cliente y su pago en arreglo
    // invoca el método pagar() del pago
    func agregarPago(cliente: Cliente, pago: Pago) {
        // 1. Imprimimos los detalles de pago
        print("#\(self.id) Procesando pago para:")
        print("CLIENTE: \(cliente.describir())")
        print("PAGO: \(pago.describir())")
        
        // 2. Llamamos al método pagar() del pago
        pago.pagar()
        
        // 3. Agregamos el cliente y el pago en forma de tupla
        //    al arreglo de pagos
        pagos.append((cliente, pago))
    }
    
    // Método mostrarPagos()
    // Imprime la lista de los pagos en esta terminal
    // Reporta el número de pagos y el total de los montos
    func mostrarPagos() {
        // 1. Reportar el número de pagos realizados en esta terminal
        print("[#\(self.id)] PAGOS: \(pagos.count)")
        print("-----------------------------------")
        // 2. Para cada pago reportamos cliente y pago
        for (cliente, pago) in pagos {
            print("TERMINAL: #\(self.id)")
            print("CLIENTE: \(cliente.describir())")
            print("PAGO: \(pago.describir())")
            print("-----------------------------------")
        }
        // Transformar el arreglo de pagos en el arreglo de montos
        // let montos = pagos.map(\.pago.monto)
        
        // 3. Recuperamos el arreglo de los montos para cada pago
        var montos: [Double] = []
        
        for (_, pago) in pagos {
            // 3.1 Agregamos el monto al arreglo de montos
            montos.append(pago.monto)
        }
        
        // 4. Calculamos el total (suma de los montos)
        var total = 0.0
        // 4.1 Para cada monto en los montos
        for monto in montos {
            // 4.2 Acumulamos el total
            total += monto
        }
        // 5. Reportamos el total de la suma de montos para cada pago
        print("TOTAL: $\(total)")
        print("-----------------------------------")
    }
}

// Prueba unitaria:

// Crear dos clientes
var cliente1 = Cliente(id: 1, nombre: "Pepe")
var cliente2 = Cliente(id: 2, nombre: "Ana")

// Crear 6 pagos
var pago1 = Pago(id: 1, descripcion: "Una coca", monto: 17.5)
var pago2 = Pago(id: 2, descripcion: "Una pepsi", monto: 12.5)
var pago3 = Pago(id: 3, descripcion: "Unas galletas", monto: 13.5)
var pago4 = Pago(id: 4, descripcion: "Un gansito", monto: 28.5)
var pago5 = Pago(id: 5, descripcion: "Un libro", monto: 245.5)
var pago6 = Pago(id: 6, descripcion: "Un osito", monto: 99.5)

// Crear una terminal
var terminal1 = TerminalPago(id: 1)

// Agregar los pagos para el cliente 1
terminal1.agregarPago(cliente: cliente1, pago: pago1)
terminal1.agregarPago(cliente: cliente1, pago: pago2)
terminal1.agregarPago(cliente: cliente1, pago: pago3)

// Agregar los pagos para el cliente 2
terminal1.agregarPago(cliente: cliente2, pago: pago4)
terminal1.agregarPago(cliente: cliente2, pago: pago5)
terminal1.agregarPago(cliente: cliente2, pago: pago6)

// Mostrar los pagos en la terminal
terminal1.mostrarPagos()

extension String {

    static func random(_ length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

print(String.random(64))
