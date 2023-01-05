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
    
    let container: NSPersistentContainer
    
    // Variable global que almacenara al empleado seleccionado
    var empleadoSeleccionado: EmpleadoEntity?
    
    // Variable global que almacenara todos los empleadosz 
    var empleados: [EmpleadoEntity]
    
    // Variable global que almacenara el pago seleccionado
    var pagoSeleccionado: PagoEntity?
    
    // Variable global que almacenara todos los pagos
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
    func empleadoLogin(correo: String, password: String) -> EmpleadoEntity

    /// Devuelve los `empleados`
    func getEmpleados() -> [EmpleadoEntity]

    /// Agrega un nuevo `EmpleadoEntity` con valores
    /// por defecto y guarda el contexto
    /// del contenedor
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaVacaciones: Bool, tienePrestamo: Bool) -> EmpleadoEntity? 
    
    /// Busca el `empleado` en los `empleados` con ese
    /// índice y guárdalo en empleadoSeleccionado
    func seleccionarEmpleado(index: Int) -> EmpleadoEntity?

    // Selecciona una fecha
    func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) -> Date

    func obtenerHistorialPagos() -> [PagoEntity]

    func seleccionarPago(index: Int) -> PagoEntity

    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) -> PagoEntity
} 
```
>Enum TipoFecha
```swift
enum TipoFecha {
        case inicioVacaciones
        case finVacaciones
        case fechaContratacion
        case fechaPago
    }
```

## Controller

> NominaController
```swift
class NominaController {
    
    // Singleton
    static let shared = NominaController()
    
    // Instancia a NominaModel
    let model = NominaModel()
    
    // Delegados para hacer notificaciones a las vistas
    var viewControllerDelegate = ViewControllerDelegate?
    var catalogoEmpleadosDelegate = CatalogoEmpleadosDelegate?
    var addEmpleadoDelegate = AddEmpleadoDelegate?
    var calendarioDelegate = CalendarioDelegate?
    var detallesEmpleadoDelegate = DetallesEmpleadoDelegate?
    var seleccionarVacacionesDelegate = SeleccionarVacacionesDelegate?
    var historialNominaDelegate = HistorialNominaDelegate?
    var detallePagoDelegate = DetallePagoDelegate?
    var addPagoDelegate = AddPagoDelegate?
    
    // Funciones 
    func empleadoLogin(correo: String, password: String) 
    
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaVacaciones: Bool, tienePrestamo: Bool)
    
    func seleccionarEmpleado(index: Int)
    
    // Selecciona una fecha
    func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) 

    func obtenerHistorialPagos()

    func seleccionarPago(index: Int)

    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?)
}
```

>ViewControllerDelegate
```swift
protocol ViewControllerDelegate {

    func empleado(empleadoLogin empleado: EmpleadoEntity)
    func empleado(empleadoLoginError message: String)
}
```
>CatalogoEmpleadosDelegate
```swift
protocol CatalogoEmpleadosDelegate {

    func empleado(empleadosCargados empleados: [EmpleadoEntity])
    func empleado(empleadoCreado empleado: EmpleadoEntity)
    func empleado(empleadoCreadoError message: String)
}
```
>AddEmpleadoDelegate
```swift
protocol AddEmpleadoDelegate {

    func empleado(fechaContratado fecha: Date)
    func empleado(empleadoCreado empleado: EmpleadoEntity)
    func empleado(empleadoCreadoError message: String)
}
```
>CalendarioDelegate
```swift
protocol CalendarioDelegate {

    func empleado(fechaSeleccionada fecha: Date)
    func empleado(fechaSeleccionadaError message: String)
}
```
>DetallesEmpleadoDelegate
```swift
protocol DetallesEmpleadoDelegate {

    func empleado(empleadoSeleccionado index: Int)
    func empleado(vacacionesSeleccionadas vacaciones: Date, tipoFecha tipo: TipoFecha)
}
```
>SeleccionarVacacionesDelegate
```swift
protocol SeleccionarVacacionesDelegate {

    func empleado(fechaSeleccionada fecha: Date, tipoFecha tipo: TipoFecha)
}
```
>HistorialNominaDelegate
```swift
protocol HistorialNominaDelegate {

    func salario(historialSalario historial: [PagoEntity]
}
```
>DetallePagoDelegate
```swift
protocol DetallePagoDelegate {

    func salario(pagoSeleccionado pago: PagoEntity
}
```
>AddPagoDelegate
```swift
protocol AddPagoDelegate {

    func salario(salarioCreado salario: PagoEntity)
    func salario(salarioCreadoError message: String)
    func salario(fechaPago fecha: Date, tipoFech tipo: TipoFecha)
}
```
