import UIKit

// Manejo de Errores

//
// - Diseña una función capaz de arrojar errores
//   que reciba una lista de productos de la estructura Producto
//   y devuelva el precio total de todos los productos.
//
//   Ocurrirá un error sí:
//   > Existe un producto sin existencias
//   > Un producto tiene un id mayor a 100
//   > El precio es mayor a 1_000
//
//   Nota: Deberás crear una enumeración para cada posible error
//
//   Crea diversas pruebas unitarias dónde:
//   * No falle
//   * Exista un producto sin existencias
//   * Exista un producto con id mayor a 100
//   * Exista un producto con precio mayor a 1_000
//
//   Utiliza do { try } catch {  } para validar cada error
//

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
//

// Concurrencia

// -

/*
 
 {
   "results": [
     {
       "gender": "female",
       "name": {
         "title": "Mrs",
         "first": "Delphine",
         "last": "Ambrose"
       },
       "email": "delphine.ambrose@example.com",
       "picture": {
         "large": "https://randomuser.me/api/portraits/women/29.jpg",
         "medium": "https://randomuser.me/api/portraits/med/women/29.jpg",
         "thumbnail": "https://randomuser.me/api/portraits/thumb/women/29.jpg"
       },
       "nat": "CA"
     },
     {
       "gender": "male",
       "name": {
         "title": "Mr",
         "first": "Darren",
         "last": "Griffin"
       },
       "email": "darren.griffin@example.com",
       "picture": {
         "large": "https://randomuser.me/api/portraits/men/46.jpg",
         "medium": "https://randomuser.me/api/portraits/med/men/46.jpg",
         "thumbnail": "https://randomuser.me/api/portraits/thumb/men/46.jpg"
       },
       "nat": "AU"
     }
   ],
   "info": {
     "seed": "a7e225d5dc0742e5",
     "results": 2,
     "page": 1,
     "version": "1.4"
   }
 }
 
 */
