import UIKit

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

class TerminalPago {
    let id: Int
    var pagos: [(cliente: Cliente, pago: Pago)] = []
    
    init(id: Int) {
        self.id = id
    }
    
    func agregarPago(cliente: Cliente, pago: Pago) {
        print("#\(self.id) Procesando pago para:")
        print("CLIENTE: \(cliente.describir())")
        print("PAGO: \(pago.describir())")
        
        pago.pagar()
        
        pagos.append((cliente, pago))
    }
    
    func mostrarPagos() {
        print("PAGOS: \(pagos.count)")
        print("-----------------------------------")
        for (cliente, pago) in pagos {
            print("TERMINAL: #\(self.id)")
            print("CLIENTE: \(cliente.describir())")
            print("PAGO: \(pago.describir())")
            print("-----------------------------------")
        }
        // Transformar el arreglo de pagos en el arreglo de montos
        // let montos = pagos.map(\.pago.monto)
        
        var montos: [Double] = []
        
        for (_, pago) in pagos {
            montos.append(pago.monto)
        }
        
        var total = 0.0
        for monto in montos {
            total += monto
        }
        print("TOTAL: $\(total)")
        print("-----------------------------------")
    }
}

var cliente1 = Cliente(id: 1, nombre: "Pepe")
var cliente2 = Cliente(id: 2, nombre: "Ana")

var pago1 = Pago(id: 1, descripcion: "Una coca", monto: 17.5)
var pago2 = Pago(id: 2, descripcion: "Una pepsi", monto: 12.5)
var pago3 = Pago(id: 3, descripcion: "Unas galletas", monto: 13.5)
var pago4 = Pago(id: 4, descripcion: "Un gansito", monto: 28.5)
var pago5 = Pago(id: 5, descripcion: "Un libro", monto: 245.5)
var pago6 = Pago(id: 6, descripcion: "Un osito", monto: 99.5)

var terminal1 = TerminalPago(id: 1)

terminal1.agregarPago(cliente: cliente1, pago: pago1)
terminal1.agregarPago(cliente: cliente1, pago: pago2)
terminal1.agregarPago(cliente: cliente1, pago: pago3)

terminal1.agregarPago(cliente: cliente2, pago: pago4)
terminal1.agregarPago(cliente: cliente2, pago: pago5)
terminal1.agregarPago(cliente: cliente2, pago: pago6)

terminal1.mostrarPagos()
