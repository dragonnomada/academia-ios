import UIKit

// Subscripts
//
// - Diseña una estructura llamada `Mensaje` que guarde el `id: Int`,
//   `usuario: String` y `contenido: String` del mensaje.
//   Diseña una clase llamada `HistorialMensajes` que retenga un
//   arreglo de mensajes.
//
//  Diseña un subscript para recuperar los mensajes por `id: Int`
//
//  Diseña un subscript para recuperar los mensajes por `usuario: String`
//
//  Nota: Los subscripts deberán devolver un `Mensaje?`


struct Mensaje {
    let id: Int
    let usuario: String
    let contenido: String
}

class HistoriaMensajes {
    var mensajes: [Mensaje]?
    
    subscript(index: Int) -> Mensaje {
        return mensajes![index]
    }
}
