# ProyectoAdministracionDeNominasEmpleados

# Proyecto Nomina Empleados

## Proyecto realizado por:

### Heber Eduardo Jimenez Rodriguez
### Joel Brayan Navor Jimenez
### Brian Jimenez Moedano


# NominApp

## Model

>EmpleadoEntity
```swift

struct EmpleadoEntity {

    let id: Int
    let nombre: String
    let area: String
    let departamento: String
    let puesto: String
    let fechaContratacion: Date
    let antiguedad: Int
    let salario: Double
    let fechaVacacionesInicio: Date
    let fechaVacacionesFin: Date
    let estaVacaciones: Bool
    let tienePrestamo: Bool
    //
    let cantidadPrestamo: Double // $$
    let cantidadRestantePrestamo: Double // $$
    let numeroAbono: Int // Numero pagos realizados 
}
```

>PagoEntity
```swift

struct PagoEntity {

    let nombreEmpleado: String
    let fechaPago: Date
    let sueldo: Double
    let viaticos: Double?
    let prestamo: Double?
    let descripcionPrestamo: String?
    let cantidadRestantePrestamo: Double? // 
    let numeroAbono: Int? // Numero pagos realizados
}
```

>NominaModel
```swift

class NominaModel {

        enum TipoFecha {
            case inicioVacaciones
            case finVacaciones
            case fechaContratacion
            case fechaPago
        }
    
        let container: NSPersistentContainer
        var empleadoSeleccionado: EmpleadoEntity?
        var empleados: [EmpleadoEntity]
        var pagoSeleccionado: PagoEntity?
        var pagos: [PagoEntity]

        /// Carga los `empleados` desde el CoreData
        func loadEmpleados() {
            // 1. Recupera el contexto
            // 2. Crea un request de `EmpleadoEntity`
            // 3. Haz un fetch en el contexto
            // 4. Actualiza los `empleados`
            // 5. devuélvelos 
        }

        // Funcion que loguea un usuario
        func empleadoLogin(correo: String, password: String) -> EmpleadoEntity {
            // ...
        }
        /// Devuelve los `empleados`
        func getEmpleados() -> [EmpleadoEntity] {
            // ...
        }

        /// Agrega un nuevo `EmpleadoEntity` con valores
        /// por defecto y guarda el contexto 
        /// del contenedor
        func addEmpleado(id: String, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaDeVacaciones: Bool, tienePrestamo: Bool, cantidadPrestamo: Double) -> EmpleadoEntity? {
            // ...
        }
    
        /// Busca el `empleado` en los `empleados` con ese
        /// índice y guárdalo en empleadoSeleccionado
        func seleccionarEmpleado(index: Int) -> EmpleadoEntity? {
            // ...
        }
        // Selecciona una fecha
        func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) -> Date {
            // ...
        }

        func obtenerHistorialPagos() -> [PagoEntity] {
            // ...
        }
        
        func seleccionarPago(index: Int) -> PagoEntity {
            // ...
        }
        
        func agregarPago(let nombreEmpleado: Strinf, let fechaPago: Date, let viaticos: Double, let prestamo: Double, let numeroAbono: Int, let descripcionPrestamo: String) {
            // ...
        }
```
