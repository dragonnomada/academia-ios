# ProyectoAdministracionDeNominasEmpleados

# Proyecto Nomina Empleados

## Proyecto realizado por:

### Heber Eduardo Jimenez Rodriguez
### Joel Brayan Navor Jimenez
### Brian Jimenez Moedano


![PantallaDeInicio](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PantallaDeInicio.png)

![CatalogoDeEmpleados](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PantallaDeCatalogoDeEmpleados.png)

![SeleccionadoUnEmpleadoDelCatalogoDeEmpleados](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/SeleccionadoUnEmpleadoDelCatalogoDeEmpleados.png)

![SeleccionarVacaciones](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PantallaParaSeleccionarVacaciones.png)

![PulsandoBotonParaSeleccionarVacaciones](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PulsandoBotonParaSeleccionarVacaciones.png)

![SeleccionarUnaFecha](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PantallaParaSeleccionarUnaFecha.png)

![AlertaDespuesDeSeleccionarUnaFecha](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/AlertaDespuesDeSeleccionarUnaFecha.png)

![GenerandoUnNUevoPago](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/GenerandoUnNUevoPago.png)

![AlertaDespuesDeGenerarUnNuevoPago](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/GeneracionDeUnNuevoPago.png

![PulsandoBotonParaGenerarNuevoPago](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PulsandoBotonParaGenerarUNNUevoPago.png)

![HistorialDeNomina](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/PulsarBotonParaHistorialDeNomina.png)

![SeleccionandoUnPago](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados/blob/main/Capturas%20de%20pantalla/SeleccionandoUnPago.png)



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
    
    // Almacena al empleado logueado
    var empleadoLogueado: EmpleadoEntity?
    
    // Almacenara al empleado seleccionado del catalogo de empleados
    var empleadoSeleccionado: EmpleadoEntity?
    
    // Almacenara todos los empleados existentes
    var empleados: [EmpleadoEntity] = []
    
    // Almacenara el pago seleccionado en el historial de pagos
    var pagoSeleccionado: PagoEntity?
    
    // Almacenara todos los pagos de un empleado dado
    var pagos: [PagoEntity] = []
    
    // Almacena la fecha de contratacion del empleado
    var fechaContratacion: Date?
    
    // Almacena la fecha de inicio de vacaciones del empleado
    var fechaInicioVacaciones: Date?
    
    // ALmacenara la fecha de fin de vacaciones del empleado
    var fechaFinVacaciones: Date?
    
    // ALmacenara la fecha en que se genera un pago al empleado
    var fechaPago: Date?
    
    // Variable global que retiene el tipo de fecha seleccionada
    var tipoFecha: TipoFecha?
    
    /// Carga todos los empleados existentes, desde nuestro "NominApp"
    func loadEmpleados() {
        // 1. Recupera el contexto
        // 2. Crea un request de `EmpleadoEntity`
        // 3. Haz un fetch en el contexto
        // 4. Actualiza los `empleados`
        // 5. devuélvelos
    }

    // Funcion que loguea un usuario
    func empleadoLogin(correo: String, password: String) -> EmpleadoEntity

    /// Devuelve los empleados y pagos
    func getEmpleados() -> [EmpleadoEntity]

    /// Agrega un nuevo EmpleadoEntity con valores
    /// por defecto y guarda el contexto
    /// del contenedor
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double) -> EmpleadoEntity? 
    
    /// Busca el empleado en los empleados con ese
    /// índice y guárdalo en empleadoSeleccionado
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) -> EmpleadoEntity?

    // Agrega fecha de contratacion a un empleado
    func addFechaContratacion(fecha: Date) -> EmpleadoEntity?
    
    // Agrega fecha de inicio de vacaciones a un empleado
    func addFechaInicioVacaciones(fecha: Date) -> EmpleadoEntity?
    
    // Agrega fecha de fin de vacaciones a un empleado
    func addFechaFinVacaciones(fecha: Date) -> EmpleadoEntity?
    
    // Agrega fecha de pago generado a un empleado
    func addFechaPago(fecha: Date) -> PagoEntity?
    
    // selecciona el empleado deseado 
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) -> EmpleadoEntity?

    // Brinda todo el historial de pagos generados a un empleado
    func obtenerHistorialPagos() -> [PagoEntity]

    // Selecciona un pago el historial de pagos de un empleado
    func seleccionarPago(index: Int, pago: PagoEntity) -> PagoEntity?

    // Genera un nuevo pago a un empleado
    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) -> PagoEntity?
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
    var viewControllerDelegate: ViewControllerDelegate?
    var catalogoEmpleadosDelegate: CatalogoEmpleadosDelegate?
    var addEmpleadoDelegate: AddEmpleadoDelegate?
    var calendarioDelegate: CalendarioDelegate?
    var detallesEmpleadoDelegate: DetallesEmpleadoDelegate?
    var seleccionarVacacionesDelegate: SeleccionarVacacionesDelegate?
    var historialNominaDelegate: HistorialNominaDelegate?
    var detallePagoDelegate: DetallePagoDelegate?
    var addPagoDelegate: AddPagoDelegate?
    
    // Funciones 
    
    // Loguea un empleado
    func empleadoLogin(correo: String, password: String)
    
    // Obtener todos los empleados existentes
    func getEmpleados ()
    
    // Crear un empleado nuevo en AddEmpleadoVC
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double)
    
    // Selecciona el tipo de fecha de contratacion.
    func seleccionarTipoFechaComoContratacion()
    
    // Selecciona el tipo de fecha de inicio de vacaciones
    func seleccionarTipoFechaComoInicioVacaciones()
    
    // Selecciona el tipo de fecha de fin de vacacciones
    func seleccionarTipoFechaComoFinVacaciones()
    
    // Selecciona el tipo de fecha de pago.
    func seleccionarTipoFechaComoFechaPago()
    
    // Almacena todas las fechas (de contratacion, de inicio de periodo vacacional,
    // de fin de periodo vacacional, y fecha en que fue generado un pago) 
    // seleccionadas del empleado que hemos seleccionado
    func guardarFechasEmpleadoSeleccionado()
    
    // Registra la fecha en que fue contratado el empleado
    func addFechaContratacionEmpleado(fecha: Date)
    
    // Registra la fecha de inicio del periodo vacacional del empleado
    func addFechaInicioVacaciones(fecha: Date)
    
    // Registra la fecha de termino del periodo vacacional del empleado
    func addFechaFinVacaciones(fecha: Date)
    
    // Registra la fecha en que se realia un pago al empleado
    func addFechaPago(fecha: Date) 
    
    // Empleado seleccionado en CatalogoEmpleadosVC
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) 
    
    // Empleado seleccionado que necesita DetallesEmpleadoVC para mostrarlo
    func getEmpleadoSeleccionado() 
    
    // Asigna las fechas de inicio y fin de periodo vacacional del empleado seleccioando
    func getEmpleadoSeleccionadoFechasVacaciones() 
    }
    
    // Obtener todo el historial de pagos del empleado
    func obtenerHistorialPagos()
    
    // Evalua el tipo de fecha deseada, despues de determinar el tipo de fecha, le aignamos la fecha(date) seleccionada.
    func seleccionarFecha(fechaSeleccionada: Date)
    
    // Selecciona un pago desde HistorialNominaVC
    func seleccionarPago(index: Int, pago: PagoEntity) 
    
    // Pago seleccionado que necesita DetallePagoVC
    func getPagoSeleccionado()

    // Generar un nuevo pago
    func agregarPago(fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?)
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

