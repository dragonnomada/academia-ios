//
//  EmpleadoModel.swift
//  ProyectoNominaEmpleados
//
//  Created by User on 04/01/23.
//

import Foundation
import CoreData
import UIKit

class EmpleadoModel {
    
    let persistentContainerEmpleadoModel: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ProyectoNominaEmpleados")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor... \(error)")
            }
        }
        
        return container
    }()
    
    var empleados: [EmpleadoEntity] = []
    
    var empleadoSeleccionado = EmpleadoEntity()
    
    let logIn: [(correo: String, password: String)] =
                [("Heber@gruposalinas.com","Heber1234"),
                 ("Joel@gruposalinas.com","Joel1234"),
                 ("Brian@gruposalinas.com", "Brian1234")]
    
    func getEmpleadoLogIn(correo: String, password: String) {
        
        let logInAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        logInAlert.addAction(UIAlertAction(title: "OK", style: .default))
        
        for logIn in self.logIn {
            if correo == logIn.correo && password == logIn.password {
                
                logInAlert.title = "¡Bienvenido!"
                logInAlert.message = "\(logIn.correo)"
                break
                
            } else {
                
                logInAlert.title = "¡ERROR!"
                logInAlert.message = "Usuario o Password no reconocido."
                
            }
        }
        UIViewController().present(logInAlert, animated: true)
    }
    
    func getEmpleados() -> [EmpleadoEntity] {
        
        let context = self.persistentContainerEmpleadoModel.viewContext
        
        let requestEmpleados = EmpleadoEntity.fetchRequest()
        
        if let empleados = try? context.fetch(requestEmpleados) {
            
            self.empleados = empleados
        }
        
        return self.empleados
    }
    
    func addEmpleado(nombre: String, area: String, departamento: String, puesto: String, salario: Double, fechaContratacion: Date) -> EmpleadoEntity? {
        
        let context = persistentContainerEmpleadoModel.viewContext
        
        let empleado = EmpleadoEntity(context: context)
        
        empleado.id = Int64(self.empleados.count + 1)
        empleado.nombre = nombre
        empleado.area = area
        empleado.departamento = departamento
        empleado.puesto = puesto
        empleado.fechaContratacion = fechaContratacion
        empleado.salario = salario
        empleado.fechaVacacionesInicio = Date()
        empleado.fechaVacacionesFin = Date()
        empleado.estaVacaciones = false
        empleado.tienePrestamo = false
        empleado.cantidadPrestamo = 0.0
        
        do {
            try context.save()
            
            let context = self.persistentContainerEmpleadoModel.viewContext
            
            let requestEmpleados = EmpleadoEntity.fetchRequest()
            
            if let empleados = try? context.fetch(requestEmpleados) {
                
                self.empleados = empleados
            }
            
            return empleado
        } catch {
            context.rollback()
            return nil
        }
    }
    
    func seleccionarEmpleado(index: Int) -> EmpleadoEntity? {
        
        guard index >= 0 && index < self.empleados.count
        else { return nil }
        
        self.empleadoSeleccionado = self.empleados[index]
        
        return self.empleadoSeleccionado
    }
    
    

}
