# Proyecto Ubicapp

## Proyecto Realizado por:
### Joel Brayan Navor Jimenez
### Heber Eduardo Jimenez Rodriguez
### Marco Antonio Jonathan Amador Hernandez

# Ubicapp Models

> Locación
```swift
struct LocacionEntity {
let id: Int
let latitud: Double
let longitud: Double
let nombre: String
let image: Binary Data
}


```swift
class UbicacionMarcadaModel { 
/// TODO:
///       1.- importacion CoreData, Combine
///       2.- Instanciar a el Contenedor Persistente
///       3.- Creación de la función para cargar la(s) ubicación(es) marcada(s).
///       4.- Creación de la función para añadir una nueva marcador.
///       5.- Creación de la función para mandar un marcador seleccionada.
///       6.- Creación de la función para actualizar un marcador selecionado
///       7.- Creaciòn de los publishers a utilizar
          
     static let shared UbicacionMarcadaModel ()
     
     var container: NSPersistentContainer = {
     
     }
     
      @Published var ubicacionesMarcadas: [LocacionEntity] = []
      @Published var ubicacionMarcadaSeleccionada: LocacionEntity?
      
      func cargarUbicacionesMarcadas() 
      
      func añadirMarcadorUbicacion(latitud: Double, longitud: Double, nombre: String?)

      func marcadorSeleccionado(id: Int) 
      
      func actualizarUbicacionMarcada(nombre: String?, latitud: Double?, longitud: Double?, imagen: Data?)
      
      func eliminarMarcador()
      
}
```
# Ubicapp Views

>Clase MapView
```swift

protocol MapView: NSObject { 

func ubicacion(añadirUbicacion ubicacion: [LocacionEntity])
func ubicacion(cargarUbicacionesMarcadas: [locacionEntity])

}

```

>Clase DetallesMarcadorView
```swift

protocol DetallesMarcadorView: NSObject { 

func ubicacion(ubicacionSeleccionada ubicacion: [LocacionEntity])
func ubicacion(ubicacionActualizada ubicacion: LocacionEntity?)

}

```


# Ubicapp ViewModels
>Clase MapaViewModel
```swift
class MapaViewModel { 

weak var model: UbicacionesModel?
weak var view:: MapaViewModel?

var ubicacionesSubscriber: AnyCancellable?
var ubicacionesSeleccionadas: AnyCancellable?

init(model: UbicacionesModel) {  
//TODO: Subscribirse 
}

deinit() { 
//TODO: Desubscribirse
}

}

```
>Clase DetallesUbicacionMarcadaViewModel
```swift
class UbicacionMarcadaViewModel { 

weak var model: UbicacionesModel?
weak var view: DetallesUbicacionViewModel?

var ubicacionesSubscriber: AnyCancelable?

// TODO: cargar todas las ubicaciones
// Publicadores
// Suscriptores

init() {  
//TODO: Subscribirse 
}

deinit() { 
//TODO: Desubscribirse
}

}

```
