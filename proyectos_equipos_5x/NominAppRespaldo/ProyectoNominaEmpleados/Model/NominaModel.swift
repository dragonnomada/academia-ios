//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado del 3 de enero del 2023 al 6 de enero del 2023
// 

import Foundation
import CoreData

class NominaModel {
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NominApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor... \(error)")
            }
        }
        
        return container
    }()
    
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
    
    let logIn: [(correo: String, password: String)] =
                [("heber@gs.com","1234"),
                 ("joel@gs.com","1234"),
                 ("brian@gs.com", "1234")]
    
    // Creando empleados por defecto, de prueba
    func instalarEmpleados() {
        //print("Instalando empleados")
        
        guard let _ = self.addEmpleado(id: 1, nombre: "Admin Ejemplo", area: "Pruebas", departamento: "Desarrollo", puesto: "Testing", fechaContratacion: Date.now, salario: 15000) else {
            return
        }
        
        guard let _ = self.addEmpleado(id: 2, nombre: "Ana Paola", area: "Contabilidad", departamento: "Recursos Financieros", puesto: "Secretaria", fechaContratacion: Date.now, salario: 10000) else {
            return
        }
        
        guard let _ = self.addEmpleado(id: 3, nombre: "Pedro Soto", area: "Administración", departamento: "Titulación", puesto: "Gerente", fechaContratacion: Date.now, salario: 17500) else {
            return
        }
    }
    
    // Carga todos los empleados y pagos existentes, desde nuestro "NominApp"
    func loadEmpleados() {
        
        let context = self.persistentContainer.viewContext
        
        let requestEmpleados = EmpleadoEntity.fetchRequest()
        
        let requestPagos = PagoEntity.fetchRequest()
        
        if let empleados = try? context.fetch(requestEmpleados) {
            
            self.empleados = empleados
        }
        
        if self.empleados.isEmpty {
            
            self.instalarEmpleados()
        }
        
        if let pagos = try? context.fetch(requestPagos) {
            
            self.pagos = pagos
        }
    }
    
    // Loguea un empleado
    func empleadoLogIn(correo: String, password: String) -> EmpleadoEntity? {
        
        self.loadEmpleados()
        
        if let empleado = self.empleados.filter({ empleado in
            
            empleado.correo == correo && empleado.password == password
            
        }).first {
            
            self.empleadoLogueado = empleado
            return empleado
        }
        return nil
    }
    
    // Agrega fecha de contratacion a un empleado
    func addFechaContratacion(fecha: Date) -> EmpleadoEntity? {
        
        if let empleado = empleadoSeleccionado {
            
            empleado.fechaContratacion = fecha
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadEmpleados()
                return empleado
            } catch {
                context.rollback()
            }
            
        }
        return nil
        
    }
    
    // Agrega fecha de inicio de vacaciones a un empleado
    func addFechaInicioVacaciones(fecha: Date) -> EmpleadoEntity? {
        
        if let empleado = empleadoSeleccionado {
            
            empleado.fechaVacacionesInicio = fecha
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadEmpleados()
                return empleado
            } catch {
                context.rollback()
            }
            
        }
        return nil
        
    }
    
    // Agrega fecha de fin de vacaciones a un empleado
    func addFechaFinVacaciones(fecha: Date) -> EmpleadoEntity? {
        
        if let empleado = empleadoSeleccionado {
            
            empleado.fechaVacacionesFin = fecha
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadEmpleados()
                return empleado
            } catch {
                context.rollback()
            }
            
        }
        return nil
        
    }
    
    // Agrega fecha de pago generado a un empleado
    func addFechaPago(fecha: Date) -> PagoEntity? {
        
        if let pago = pagoSeleccionado {
            
            pago.fechaPago = fecha
            
            let context = self.persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadEmpleados()
                return pago
            } catch {
                context.rollback()
            }
            
        }
        return nil
        
    }
    
    // Devuelve los empleados y pagos
    func getEmpleados() -> [EmpleadoEntity] {
        
        self.loadEmpleados()
        return self.empleados
    }
    
    func guardarEmpleadoSeleccionado() {
        
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            context.rollback()
        }
        
    }
    
    // Genera un empleado nuevo
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double) -> EmpleadoEntity? {
        
        print("Recibiendo empleado: \(id) \(nombre)")
        
        let context = persistentContainer.viewContext
        
        let empleado = EmpleadoEntity(context: context)
        
        empleado.id = Int32(id)
        empleado.nombre = nombre
        empleado.area = area
        empleado.departamento = departamento
        empleado.puesto = puesto
        empleado.fechaContratacion = fechaContratacion
        empleado.antiguedad = Int32(0)
        empleado.salario = salario
        empleado.fechaVacacionesInicio = nil
        empleado.fechaVacacionesFin = nil
        empleado.estaVacaciones = false
        empleado.tienePrestamo = false
        empleado.correo = "empleado_\(empleado.id)@empresa.com"
        empleado.password = "empleado_\(empleado.id)"
        
        do {
            try context.save()
            
            self.loadEmpleados()
            
            print("Empleado guardado: \(id) \(nombre)")
            
            return empleado
        } catch {
            context.rollback()
            return nil
        }
    }
    
    // selecciona el empleado deseado
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) -> EmpleadoEntity? {
        
        guard index >= 0 && index < self.empleados.count
        else { return nil }
        
        self.empleadoSeleccionado = self.empleados[index]
        
        return self.empleadoSeleccionado
    }
    
    /*func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) -> Date {
        
        switch tipoFecha {
        case inicioVacaciones: return self.empleadoSeleccionado.fechaVacacionesInicio ?? Date().self
        case finVacaciones: return self.empleadoSeleccionado.fechaVacacionesFin ?? Date.self
        case fechaContratacion: return self.empleadoSeleccionado.fechaContratacion ?? Date.self
        case fechaPago: return self.pagoSeleccionado.fechaPago ?? Date().self
        default: return Date().self
        }
    }*/
    
    // Brinda todo el historial de pagos generados a un empleado
    func obtenerHistorialPagos() -> [PagoEntity] {
        
        self.loadEmpleados()
        return self.pagos
    }
    
    // Selecciona un pago el historial de pagos de un empleado
    func seleccionarPago(index: Int, pago: PagoEntity) -> PagoEntity? {
        
        guard index >= 0 && index < self.pagos.count
        else { return nil }
        
        let pagos = self.pagos.filter {
            pago in
            pago.empleado == self.empleadoSeleccionado
        }
        
        self.pagoSeleccionado = pagos[index]
        
        return self.pagoSeleccionado
    }
    
    // Genera un nuevo pago a un empleado
    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) -> PagoEntity? {
        
        let context = persistentContainer.viewContext
        
        let pago = PagoEntity(context: context)
        
        pago.nombreEmpleado = nombreEmpleado
        pago.fechaPago = fechaPago
        pago.sueldo = sueldo
        pago.viaticos = viaticos ?? 0.0
        pago.prestamo = prestamo ?? 0.0
        pago.descripcionPrestamo = descripcionPrestamo ?? ""
        pago.cantidadRestantePrestamo = cantidadRestantePrestamo ?? 0.0
        pago.numeroAbono = Int32(numeroAbono ?? 0)
        
        if let empleadoSeleccionado = self.empleadoSeleccionado {
            
            pago.empleado = empleadoSeleccionado
        }
        
        do {
            try context.save()
            
            self.loadEmpleados()
            
            return pago
        } catch {
            context.rollback()
            return nil
        }
    }
}
