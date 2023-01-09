# Notas de Combine

## Observabilidad

La observación de un objeto/variable se da a través de dos partes:

* **Publicador (`Publisher`)** - El publicar publica los cambios que le ocurren al objeto/variable asociada (`assocType output`), esto se logra a través del protocolo `Publisher`
* **Suscriptor (`Subscriber`)** - El suscriptor escucha los cambios que le ocurren a un objeto/variable asociada (`assocType input`), esto se logra a través del protocolo `Subscriber`

A través del *Framework Combine* podemos crear publicadores y suscriptores.

### Paso 1 - Establecer que un objeto/variable será publicada a través de `@Published`

> Ejemplo para crear un `Publisher` a través `@Published`

```swift
import Combine

class MyClass {

    @Published var myNumber: Int = 0

}
```

### Paso 2 - Podemos acceder al publicador del objeto/variable

Este tiene el mismo nombre pero anteponiendo el sufijo `$`.

> Ejemplo para suscribir un `@Published`

```swift
// Dentro de la clase
self.$myNumber

// Fuera de la clase

myClass.$myNumber
```
