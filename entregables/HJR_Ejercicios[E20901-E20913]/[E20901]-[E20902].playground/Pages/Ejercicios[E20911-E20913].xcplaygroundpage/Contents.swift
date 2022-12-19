/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 14-12-22
 
 Ejercicios [E20911-E20913]
 */

import Foundation

/*
[E20911*] - Crear una clase para un robot móvil en 2D que tenga una coordenada x entera y una coordena y entera, con los métodos para mover al norte, al sur, al este y al oeste. Nota: Sin valores por defecto o inicializadores no podremos definir la clase.
*/
class Robot {
  var x: Int
  var y: Int

  // [E20912] - Agrega un inicializador para recibir la x y la y
    init?() {
    self.x = x
    self.y = y
   // [E20913] - Provocar un fallo si las coordenadas son negativas
    if (x < 0) {
      return nil
    }
  }
  func moverAlNorte () {
    y+=1
  }

  func moverAlSur () {
    y-=1
  }

  func moverAlEste () {
    x+=1
  }

  func moverAlOeste () {
    x-=1
  }
}

