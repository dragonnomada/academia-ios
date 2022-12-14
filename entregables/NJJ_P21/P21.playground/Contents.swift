/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
 Creado el 12 de Diciembre de 2022
 Practica 21 - Manejo de estructuras, Clases y protocolos
*/

import UIKit
//Estructura Clientes retienne los datos de un cliente
struct Cliente {
    //Parametros
    let id: Int
    var nombre: String
    var activo: Bool = true
    
    //Inicializador de la estructura
    init(idInicial: Int, nombreInicial: String) {
        self.id = idInicial
        self.nombre = nombreInicial
        
    }
    //Metodo Describir Cliente
    func DescribirCliente()-> String{
        return " El cliente \(self.nombre), con la id: \(self.id), con el estado: \(activo)"
    }
    
}

//clase Pagos retiene los datos de la clase pago
//*se modifico la estructura pago por una clase para mutabilidad
class Pago{
    //parametros
    let id: Int
    var descripcion: String
    var monto: Double
    var pagado: Bool = false
    
    //inicializador de la estructura pagos
    init(idInicial: Int, descripcionInicial: String, montoInicial: Double) {
        self.id = idInicial
        self.descripcion = descripcionInicial
        self.monto = montoInicial
    }
    
    //Metodo Pagar
    func pagar(){
        self.pagado = true
    }
    //Metodo Describir
    func Describir()->String{
        return "La id \(self.id), con el monto: \(self.monto) de el producto \(descripcion) se encuentra con el estado pagado: \(self.pagado)"
    }
}

//Clase Terminal Pago - Retiene un arreglo de clientes y pagos
class terminalPago{
    //parametros
    let id: Int
    var pagos:  [(cliente : Cliente, pago: Pago)] = []
    
    //Inicializador
    init(idInicial: Int){
        self.id = idInicial
    }
    
    //Funcion agregarPago - Funcion o metodo agregar pago (cliente: Cliente, pago: Pago)
    //Registra a un cliente y su pago en arreglo
    //invoca el metodo pagar() del pago
    func agregarPago(cliente: Cliente, pago: Pago){
        print("#Procesando pago para \(cliente.id)")
        print("Cliente: \(cliente.DescribirCliente())")
        print("Pago: \(pago.descripcion)")
        
    }
    
    //Funcion mostrarPagos()
    //imprime la lista de los pagos en esta temrinal
    func mostrarPago(){
        //Reporta el numero de pagos realizados en esta terminal
        print(" #\(self.id) Pagos: \(pagos.count)")
        print("---------------------")
        for (cliente,pago )in pagos  {
            print("Terminal: #\(self.id)")
            print("Cliente: \(cliente.DescribirCliente())")
            print("Pago: \(pago.Describir())")
            print("------------")
            
        }
        //Transformar el arreglo de pagos en el arreglo de montos
        
        //sacar monto
        //Calculamos el total (suma de los montos)
        let montos = pagos.map(\.pago.monto)
        var total = 0.0
        for monto in montos{
            total += monto
        }
        //Reportamos el total de la suma de montos para cada pago
        print("Total: \(total)")
    }
}

//Pruebas Unitarias
//Crear dos clientes
var cliente1 = Cliente(idInicial: 1, nombreInicial: "Joel")
var cliente2 = Cliente(idInicial: 2, nombreInicial: "Pablo")


//Crear 6 pagos
var pago1 = Pago(idInicial: 1, descripcionInicial: "Cocacola", montoInicial: 20.50)
var pago2 = Pago(idInicial: 2, descripcionInicial: "Papas", montoInicial: 15.50)
var pago3 = Pago(idInicial: 3, descripcionInicial: "Chicles", montoInicial: 2.50)
var pago4 = Pago(idInicial: 4, descripcionInicial: "Chetos", montoInicial: 10.50)
var pago5 = Pago(idInicial: 5, descripcionInicial: "Burritos", montoInicial: 8.50)
var pago6 = Pago(idInicial: 6, descripcionInicial: "Cerveza", montoInicial: 4.50)

//Crear una terminal
var terminal1 = terminalPago(idInicial: 1)

//Agregar los pagos para el cliente 1
terminal1.agregarPago(cliente: cliente1, pago: pago1)
terminal1.agregarPago(cliente: cliente1, pago: pago2)
terminal1.agregarPago(cliente: cliente1, pago: pago3)

//Agregar los pagos para el cliente 2
terminal1.agregarPago(cliente: cliente2, pago: pago4)
terminal1.agregarPago(cliente: cliente2, pago: pago5)
terminal1.agregarPago(cliente: cliente2, pago: pago6)

//Mostrar los pagos en la terminal
terminal1.mostrarPago()


