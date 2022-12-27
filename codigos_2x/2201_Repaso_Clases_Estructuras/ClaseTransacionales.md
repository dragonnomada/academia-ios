Una empresa de comina maneja transacciones en sus pedidos los cuales involucran:

LevantamientoPedido
SeguimientoPedido
PagoPedido
CancelacionPedido
CierrePedido

> Clase `LevantamientoPedido`

```swift
class LevantamientoPedido {

    var pedidos: [Pedido] = []

    func numeroPedidosPorCliente(_ cliente: Cliente) {
        return pedidos.map(\.cliente).filter({ otroCliente -> Bool in otraCliente.id == cliente.id }).count
    }

    func crearPedido(cliente: Cliente, recepcionista: Recepcionista) -> Pedido? {
        // TODO: Si el cliente no está activo regresa nil
        // TODO: Si el recepcionista no tiene un estado activo regresa nil
        // TODO: Si el horario no es laboral regresa nil
        // pedidos.map({ pedido -> Cliente in pedido.cliente })
        if numeroPedidosPorCliente(cliente) > 3 {
            return nil
        }
        var pedido = Pedido(cliente: cliente, recepcionista: recepcionista)
        pedidos.append(pedido)
        return pedido
    }

    func obtenerPedidoPorId(_ idPedido: Int) -> Pedido? {
        // Variable de retención
        // 1. Creamos una variable que retenga el pedido encontrado
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        // NJJ - 13/12/22 Se cambió el nombre de variable
        var pedidoEncontrado : Pedido? = nil
        // 2. Recorremos cada pedido de los levantados
        for pedido in pedidos {
            // 3. Comparamos si el idPedido buscado es el de algún pedido
            if pedido.id == idPedido {
                // 4. Actualizamos la variable del pedido encontrado
                // HJR - 15/12/22 Se corrigió una variable modificada
                pedidoEncontrado = pedido
            }
        }
        // 5. Devolvemos el pedido encontrado o nil si no lo encontró
        return pedidoEncontrado

        // return pedidos.filter({ pedido: Bool -> pedido.id == idPedido }).first
    }

    func asignarCocina(idPedido: Int, cocina: Cocina) -> Bool {
        // 1. Recuperamos el pedido por idPedido
        /*if let pedido = obtenerPedidoPorId(idPedido) {
            // TODO: CONTINUAR
        } else {
            return false
        }*/

        guard var pedido = obtenerPedidoPorId(idPedido) else { return false }
        // 2. Asignamos la cocina ese pedido
        pedido.cocina = cocina
        // 3. Cambiamos el estado del pedido
        pedido.estadoPedido = .asignoCocina
        return true
    }
    
    func asignarRepartidor(idPedido: Int, repartidor: Repartidor) -> Bool {
        // 1. Retenemos el pedido y si no regresamos falso
        guard var pedido = obtenerPedidoPorId(idPedido) else { return false }
        // 2. Asignamos repartidor a pedido
        pedido.repartidor = repartidor
        // 3. Actualizamos estado del pedido
        pedido.estadoPedido = .asignoRepartidor
        // 4. Devolvemos que se asigno el repartido de manera correcta.
        return true
    }

}
```

## Conclusiones

Al diseñar una clase pensamos en las funcionalidades que debemos implementar para el sistema y de ahí los datos que se esperan recibir como parámetros y los datos que se piensan retener en propiedades.