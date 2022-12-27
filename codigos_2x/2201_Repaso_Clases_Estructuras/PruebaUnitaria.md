```swift
// Generar el contexto de la prueba unitaria

// Contexto:
// Se probará el levantamiento de dos pedidos a dos clientes diferentes sobre la misma cocina y mismo recepcionista

func prueba1() -> Bool {
    let cocina = Cocina(1, "La lomas", "Av. Lomas Altas 123")

    let cliente1 = Cliente(1, "Pepe")

    let cliente2 = Cliente(2, "Ana")

    let recepcionista = Recepcionista(15, "Pepelucho")

    var administradorLevantamientoPedidos = LevantamientoPedido()

    guard var pedido1 = administradorLevantamientoPedidos.creaPedido(cliente1, recepcionista) else { return false }

    if administradorLevantamientoPedidos.asignarCocina(pedido1.id, cocina) {
        print("Cocina asignada al pedido 1")
    } else {
        return false
    }

    guard var pedido2 = administradorLevantamientoPedidos.creaPedido(cliente2, recepcionista) else { return false }

    if administradorLevantamientoPedidos.asignarCocina(pedido2.id, cocina) {
        print("Cocina asignada al pedido 2")
    } else {
        return false
    }

}
```