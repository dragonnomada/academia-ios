/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 14-12-22
 
 Ejercicios [E20903-E20906]
 */

import Foundation

/*
/*
[E20903] - Crear una estructura que modele los datos de una jarra en tipo estructura (capacidad en mililitros y cupo máximo en militros). Agregar métodos como vaciar(), llenar(), agregar(mililitros) -> Int, estaVacía() -> Bool y estaLlena() -> Bool
*/

struct Jarra {
  var capacidad: Double
  var cupoMax: Double

  init(capacidad: Double) {
        self.capacidad = 1000.0
        self.cupoMax = 500.0
    }

  func vaciar () {
    capacidad = 0.0
  }

  func llenar () {
    for mililitro in capacidad {
      if mililitro =< capacidad {
        mililitro += 1.0
      }
    }
  }

  func agregar () -> Int {
   
  }

  func estaVacia () -> Bool {
    if capacidad == 0.0 {
      return true
    }
  }

  func estaLlena () -> Bool {
    if cupoMax {
      return true
    }
  }
}

/*
[E20904] - Probar distintas jarras y reportar que sus capacidades no se afectan en copias
*/
var jarraVerde = Jarra(capacidad: 4000.0)
var jarraRoja = Jarra(capacidad: 4000.0)
*/


/*
[E20905] - Cambiar la estructura a clase
*/

class JarraClase {
  var capacidad: Double
  var cupoMax: Double

  init(capacidad: Double) {
        self.capacidad = 1000.0
        self.cupoMax = 500.0
    }
}

/*
[E20906] - Reportar en distintas jarras copiadas que la capacidad si modifica a través de las copias
*/
var jarraAzul = JarraClase(capacidad: 4000.0)
print(jarraAzul)
var jarraAmarilla = JarraClase(capacidad: 4000.0)
print(jarraAmarilla)

jarraAzul.capacidad = 500.0
jarraAzul.cupoMax = 300.0
print(jarraAzul)

jarraAmarilla.capacidad = 10.0
jarraAmarilla.cupoMax = 30.0
print("La jarra Amarilla tiene la capacidad de: \(jarraAmarilla.capacidad)")


