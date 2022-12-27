```swift
struct CajeroVirtual {
    let id: String
    let dinero: Double
    let clientes: [(idCliente: String, montoRetiro: Double, veces: Int, diasEspera: Int)]
}

protocol CarteraDinero {
    
    func ingresarDinero(idCartera: String, idCliente: String, monto: Double) -> String?

    func retirarDinero(idCartera: String, idCliente: String, monto: Double) -> String?

}

class CajerApp: CarteraDinero {

    var cajeroVirtual: CajeroVirtual?

    var hayCajero : Bool {
        get { self.cajeroVirtual != nil }
    }

    var hayFondos : Bool {
        get { 
            guard dinero = self.cajeroVirtual?.dinero else { return false }
            return dinero > 0
        }
    }

    func crearCajero(idCajero: String, idCliente: String) {
        self.cajeroVirtual = CajeroVirtual(id: idCajero, dinero: 0.0, clientes: [
            (idCliente: idCliente, montoRetiro: Double.max, veces: Int.max, diasEspera: 0)
        ])
    }

    func enlazarCajero(cajeroVirtual: CajeroVirtual, idCliente: String, montoRetiro: Double, veces: Int, diasEspera: Int) {
        self.cajeroVirtual = cajeroVirtual
        self.cajeroVirtual.clientes.append([
            (idCliente, montoRetiro, veces, diasEspera)
        ])
    }

    func ingresarDinero(idCartera: String, idCliente: String, monto: Double) -> String? {
        if cajeroVirtual == nil { return nil }
        // Validar que el cajero tenga fondos suficientes
        guard dinero = self.cajeroVirtual?.dinero else { nil }
        if dinero < monto { return nil } 
        for clienteInfo in self.cajeroVirtual?.clientes.enumerated() {
            if clienteInfo.idCliente == idCliente {
                if clienteInfo.veces > 0 {
                    // TODO: Llamar al API del Oxxo para registrar un nuevo retiro en efectivo
                    self.cajeroVirtual?.dinero = dinero - monto
                    clienteInfo.veces -= 1
                    self.cajeroVirtual?.clientes[index] = clienteInfo
                    let cadenaPago = apiOxxo.ingresarEfectivo(monto)
                    return cadenaPago
                }
            }
        }
        return nil
    }

    func retirarDinero(idCartera: String, idCliente: String, monto: Double) -> String? {
        if cajeroVirtual == nil { return nil }
        // Validar que el cajero tenga fondos suficientes
        guard dinero = self.cajeroVirtual?.dinero else { nil }
        if dinero < monto { return nil } 
        for clienteInfo in self.cajeroVirtual?.clientes.enumerated() {
            if clienteInfo.idCliente == idCliente {
                if clienteInfo.veces > 0 {
                    // TODO: Llamar al API del Oxxo para registrar un nuevo retiro en efectivo
                    self.cajeroVirtual?.dinero = dinero - monto
                    clienteInfo.veces -= 1
                    self.cajeroVirtual?.clientes[index] = clienteInfo
                    let cadenaRetiro = apiOxxo.retiroEfectivo(monto)
                    return cadenaRetiro
                }
            }
        }
        return nil
    }

}
```