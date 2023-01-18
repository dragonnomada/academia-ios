//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 5 de enero del 2023
//

import Foundation


// Enum que brinda la ayuda para elegir el tipo de fecha que seleccionamos
enum TipoFecha {
        case inicioVacaciones
        case finVacaciones
        case fechaContratacion
        case fechaPago
    }

class NominaController {
    
    // Singleton
    static let shared = NominaController()
    
    // Instancia a NominaModel
    let model = NominaModel()
    
    // MARK: Delegados para hacer notificaciones a las vistas
    
    var viewControllerDelegate: ViewControllerDelegate?
    var catalogoEmpleadosDelegate: CatalogoEmpleadosDelegate?
    var addEmpleadoDelegate: AddEmpleadoDelegate?
    var calendarioDelegate: CalendarioDelegate?
    var detallesEmpleadoDelegate: DetallesEmpleadoDelegate?
    var seleccionarVacacionesDelegate: SeleccionarVacacionesDelegate?
    var historialNominaDelegate: HistorialNominaDelegate?
    var detallePagoDelegate: DetallePagoDelegate?
    var addPagoDelegate: AddPagoDelegate?
    
    // MARK: Funciones
    
    // Loguea un empleado
    func empleadoLogin(correo: String, password: String) {
        
        if let empleado = self.model.empleadoLogIn(correo: correo, password: password) {
            self.viewControllerDelegate?.empleado(empleadoLogin: empleado)
        } else {
            self.viewControllerDelegate?.empleado(empleadoLoginError: "Error al iniciar sesión con \(correo)")
        }
        
    }
    
    // Obtener todos los empleados existentes
    func getEmpleados () {
        
        let empleados = self.model.getEmpleados()
        
        catalogoEmpleadosDelegate?.empleado(empleadosCargados: empleados)
        
    }
    
    // Crear un empleado nuevo en AddEmpleadoVC
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double) {
        
        //print("Agregando empleado \(id) \(nombre)")
        
        if let empleado = self.model.addEmpleado(id: Int(Int32.random(in: 1...Int32.max)), nombre: nombre, area: area, departamento: departamento, puesto: puesto, fechaContratacion: fechaContratacion, salario: salario) {
            
            // Se le notifica a AddEmpleadoViewController y CatalogoEmpleadosViewController
            // que un empleado nuevo a sido generado, y se les pasas ese empleado generado.
            addEmpleadoDelegate?.empleado(empleadoCreado: empleado)
            catalogoEmpleadosDelegate?.empleado(empleadoCreado: empleado)
            
        }
    }
    
    // Selecciona el tipo de fecha de contratacion.
    func seleccionarTipoFechaComoContratacion() {
        
        // Asigna el tipo de fecha, como fecha de contratacion del empleado
        self.model.tipoFecha = .fechaContratacion
        
    }
    
    // Selecciona el tipo de fecha de inicio de vacaciones
    func seleccionarTipoFechaComoInicioVacaciones() {
        
        // Asigna el tipo de fecha, como fecha de inicio de periodo vacacional del empleado
        self.model.tipoFecha = .inicioVacaciones
        
    }
    
    // Selecciona el tipo de fecha de fin de vacacciones
    func seleccionarTipoFechaComoFinVacaciones() {
        
        // Asigna el tipo de fecha, como fecha de fin de periodo vacacional del empleado
        self.model.tipoFecha = .finVacaciones
        
    }
    
    // Selecciona el tipo de fecha de pago.
    func seleccionarTipoFechaComoFechaPago() {
        
        // Asigna el tipo de fecha, como fecha en que fue generado un pago al empleado
        self.model.tipoFecha = .fechaPago
        
    }
    
    // Almacena todas las fechas (de contratacion, de inicio de periodo vacacional,
    // de fin de periodo vacacional, y fecha en que fue generado un pago) seleccionadas
    // del empleado que hemos seleccionado
    func guardarFechasEmpleadoSeleccionado() {
        self.model.guardarEmpleadoSeleccionado()
    }
    
    // Registra la fecha en que fue contratado el empleado
    func addFechaContratacionEmpleado(fecha: Date) {
        
        if self.model.empleadoSeleccionado != nil {
            
            if let empleado = self.model.addFechaContratacion(fecha: fecha) {
                
                // Notifica por medio de delegados, a CatalogoEmpleadosViewController y a
                // DetallesEmpleadoViewController que se agrego la fecha de contratacion al
                // empleado, para que puedan mostrar dicho dato, en sus vistas.
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    // Registra la fecha de inicio del periodo vacacional del empleado
    func addFechaInicioVacaciones(fecha: Date) {
        
        if self.model.empleadoSeleccionado != nil {
            
            if let empleado = self.model.addFechaInicioVacaciones(fecha: fecha) {
                
                // Notifica por medio de delegados, a CatalogoEmpleadosViewController y a
                // DetallesEmpleadoViewController cual es la fecha en que inicia el
                // periodo vacacional del empleado.
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    // Registra la fecha de termino del periodo vacacional del empleado
    func addFechaFinVacaciones(fecha: Date) {
        
        if self.model.empleadoSeleccionado != nil {
            
            if let empleado = self.model.addFechaFinVacaciones(fecha: fecha) {
                
                // Notifica por medio de delegados, a CatalogoEmpleadosViewController y a
                // DetallesEmpleadoViewController cual es la fecha en que termina el
                // periodo vacacional del empleado.
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    // Registra la fecha en que se realia un pago al empleado
    func addFechaPago(fecha: Date) {
        
        if let empleadoSelected = self.model.empleadoSeleccionado {
            
            if let _ = self.model.addFechaFinVacaciones(fecha: fecha) {
                
                // Notifica por medio de delegados, a CatalogoEmpleadosViewController y a
                // DetallesEmpleadoViewController que se agrego la fecha al pago generado
                // al empleado
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleadoSelected)
            }
        }
    }
    
    // Empleado seleccionado en CatalogoEmpleadosVC
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) {
        
        if let empleado = model.seleccionarEmpleado(index: index, empleado: empleado) {
            
            // Notifica a CatalogoEmpleadosViewController y a DetallesEmpleadoViewController
            // que se ha seleccionado un empleado del catalogo de empleados.
            catalogoEmpleadosDelegate?.empleado(empleadoSeleccionado: empleado, index: index)
        }
    }
    
    // Empleado seleccionado que necesita DetallesEmpleadoVC para mostrarlo
    func getEmpleadoSeleccionado() {
        
        if let empleadoSeleccionado = self.model.empleadoSeleccionado {
            
            // Notifica a DetallesEmpleadoViewController cual fue ese empleado seleccionado
            detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleadoSeleccionado)
        }
    }
    
    // Asigna las fechas de inicio y fin de periodo vacacional del empleado seleccioando
    func getEmpleadoSeleccionadoFechasVacaciones() {
        
        //print("OBTENIENDO FECHAS VACACIONES")
        if let empleadoSeleccionado = self.model.empleadoSeleccionado {
            
            print("EL EMPLEADO SELECCIONADO ES: \(empleadoSeleccionado)")
            
            
            if let fechaVacacionesInicio = empleadoSeleccionado.fechaVacacionesInicio {
                
                // Asigna la fecha de inicio de periodo vacacional al empleado seleccionado
                seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaVacacionesInicio, tipoFecha: .inicioVacaciones)
            }
            
            
            if let fechaVacacionesFin = empleadoSeleccionado.fechaVacacionesFin {
                
                // Asigna la fecha de fin de periodo vacacional al empleado seleccionado
                seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaVacacionesFin, tipoFecha: .finVacaciones)
            }
        }
    }
    
    // Obtener todo el historial de pagos del empleado
    func obtenerHistorialPagos() {
        
        //print("Empleado seleccionado: \(self.model.empleadoSeleccionado?.id ?? -1)")
        
        // Brinda todo el historial de los pagos de un empleado, y se filtra, para poder
        // obtener, solo el historial del empleado que a sido seleccioando
        historialNominaDelegate?.pago(historialPagos: self.model.pagos.filter({
            pago in
            pago.empleado == self.model.empleadoSeleccionado
        }))
        
    }
    
    // Evalua el tipo de fecha deseada, despues de determinar el tipo de fecha, le aignamos la fecha(date) seleccionada.
    func seleccionarFecha(fechaSeleccionada: Date) {
        
        switch self.model.tipoFecha {
        
        case .fechaContratacion:
            self.model.fechaContratacion = fechaSeleccionada
            self.addEmpleadoDelegate?.empleado(fechaContratado: fechaSeleccionada)
        case .inicioVacaciones:
            self.model.fechaInicioVacaciones = fechaSeleccionada
            self.seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaSeleccionada, tipoFecha: .inicioVacaciones)
        case .finVacaciones:
            self.model.fechaFinVacaciones = fechaSeleccionada
            self.seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaSeleccionada, tipoFecha: .finVacaciones)
        case .fechaPago:
            self.model.fechaPago = fechaSeleccionada
            self.addPagoDelegate?.salario(fechaPago: fechaSeleccionada, tipoFech: .fechaPago)
        default:
            print("Tipo de fecha no válido")
        }
    }
    
    // Selecciona un pago desde HistorialNominaVC
    func seleccionarPago(index: Int, pago: PagoEntity) {
        
        if let pago = model.seleccionarPago(index: index, pago: pago) {
            
            // Notifica a HistorialNominaViewController que un pago ha sido seleccioando
            historialNominaDelegate?.pago(pagoSeleccionado: pago, index: index)
        }
        
    }
    
    // Pago seleccionado que necesita DetallePagoVC
    func getPagoSeleccionado() {
        
        if let pagoSeleccionado = self.model.pagoSeleccionado {
            
            // Notifica a DetallePagoViewController cual fue el empleado seleccioando
            detallePagoDelegate?.salario(pagoSeleccionado: pagoSeleccionado)
        }
    }

    // Generar un nuevo pago
    func agregarPago(fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) {
        
        if let pago = self.model.agregarPago(nombreEmpleado: self.model.empleadoSeleccionado?.nombre ?? "DESCONOCIDO", fechaPago: fechaPago, sueldo: sueldo, viaticos: viaticos, prestamo: prestamo, descripcionPrestamo: descripcionPrestamo, cantidadRestantePrestamo: cantidadRestantePrestamo, numeroAbono: numeroAbono) {
            
            addPagoDelegate?.salario(salarioCreado: pago)
            
        } else {
            addPagoDelegate?.salario(salarioCreadoError: "No se pudo crear el pago.")
        }
    }
}

