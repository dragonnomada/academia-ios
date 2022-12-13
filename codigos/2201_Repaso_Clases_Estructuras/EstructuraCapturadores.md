Una empresa de comida maneja pedidos de comida los cuales involucran:

Pedido
Cliente
Recepcionista
Repartidor
Cocina
EstadoPedido
EstadoPago

> Estructura `Pedido`

```swift
enum EstadoPedido {
    case nuevo
    // Cuándo el pedido ya asignó una cocina
    case asignoCocina
    case asignoRepartidor
    case cancelado
    case enEntrega
    case completado
}

enum EstadoPago {
    case sinPagar
    case enProcesoPago
    case pagoCancelado
    case pagoRechazado
    case pagoCompletado
}

struct Pedido {
    let id: Int
    let cliente: Cliente
    var cocina: Cocina?
    var estadoPedido: EstadoPedido = .nuevo
    var estadoPago: EstadoPago = .sinPagar
    var repartidor: Repartidor?
    let recepcionista: Recepcionista

    var detalles: String {
        get { "[\(self.id)] \(Cliente) ..." }
    }  
}
```

> Estructura `Cliente`

```swift
enum MetodoPago {
    case efectivo
    case tarjetaCredito(String)
    case tarjetaDebito(String)
    case transferencia(String, String)
}

struct Cliente {
    let id: Int
    let nombre: String
    let ubicacion: String
    let metodoPago: MetodoPago 
}
```

> Estructura `Repartidor`

```swift
enum EstadoRepartidor {
    case disponible
    case esperandoPedido(Pedido)
    case recibiendoPedido(Pedido, Int)
    case entregandoPedido(Pedido, Int)
}

struct Repartidor {
    let id: Int
    let nombre: String
    let estadoRepartidor: EstadoRepartidor
    let numeroTelefono: String

    var estaDisponible: Bool {
        get { self.estadoRepartidor == .disponible }
    }

}
```

## Conclusiones

Al diseñar estructuras modelamos partiendo de las propiedades que queremos retener y pensamos en un estado de datos que queremos alcanzar, por ejemplo, para retener los datos un correo por enviar, para retener los datos de un correo recibido, para retener los datos de un paquete por enviar, para retener los datos de un cliente consultado desde la base de datos o desde el api.

Y así las estructuras son literalmente estructuraciones de datos (paquetes de datos o los datos transaccionales).