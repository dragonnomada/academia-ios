//
//  BitacoraModel.swift
//  BitacorAPP
//
//  Created by Dragon on 11/01/23.
//
//  Mantained by Alan Badillo Salas
//
//  Changes:
//  * [11/01/23] Definition of BitacoraModel class
//  * [11/01/23] Add code (not tested)
//  * [12/01/23] Singleton removed for security
//

import Foundation
import CoreData
import Combine

/// Instance of application retained data (used by view-models)
class BitacoraModel {
    
    // COREDATA CONTAINER
    
    /// Container of model (to store objects to `CoreData`)
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BitacorApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("Error while loading ´BitacorApp´ container. Reason: \(error)")
            }
        }
        
        return container
    }()
    
    // MODEL STATES
    
    /// List of *bitácoras*
    @Published var bitacoras: [BitacoraEntity] = []
    
    /// List of *status of bitácoras*
    @Published var bitacoraStatus: [BitacoraStatusEntity] = []
    
    /// Current selected *bitácora* if exists
    @Published var bitacoraSelected: BitacoraEntity?
    
    /// List of *status* of current selected *bitácora* when is selected
    @Published var statusOfBitacoraSelected: [BitacoraStatusEntity] = []
    
    // MODEL OPERATIONS
    
    /// Load list of *bitácoras* from the *CoreData*
    func loadBitacoras() {
        
        // Request all *bitácoras* from the container-context
        
        let context = self.container.viewContext
        
        let bitacorasRequest = BitacoraEntity.fetchRequest()
        
        if let bitacoras = try? context.fetch(bitacorasRequest) {
            self.bitacoras = bitacoras
        }
        
    }
    
    /// Load list of *status of bitácoras* from the *CoreData*
    func loadStatusOfBitacoras() {
        
        // Request all *status of bitácoras* from the container-context
        
        let context = self.container.viewContext
        
        let bitacorasStatusRequest = BitacoraStatusEntity.fetchRequest()
        
        guard let bitacorasStatus = try? context.fetch(bitacorasStatusRequest) else {
            // TODO: Notify error (fetch error)
            return
        }
        
        self.bitacoraStatus = bitacorasStatus
        
    }
    
    /// Find the *bitácora* by *id*, filter them *status of this bitácora*
    /// and finally set-up the current selected *bitácora*
    /// and the current *status of bitácora* list
    func selectBitacora(byId id: Int) {
        
        // Find the first *bitácora* with the *id*
        
        if let bitacoraFound = self.bitacoras.filter({
            bitacora in
            bitacora.id == id
        }).first {
            
            // Update the current selected *bitácora*
            
            self.bitacoraSelected = bitacoraFound
            
            // Filter the *status* of the *bitácora* found
            
            self.loadStatusOfBitacoras()
            
            self.statusOfBitacoraSelected = self.bitacoraStatus.filter {
                status in
                status.bitactora == bitacoraFound
            }
            
        } else {
            // TODO: Notify error (bitacora not found)
        }
    }
    
    /// Create new *bitácora* with new max *id* and select it
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal) {
        
        // Create new instance of *BitacoraEntity* in the current container-context
        
        let context = self.container.viewContext
        
        let bitacoraToAdd = BitacoraEntity(context: context)
        
        // Set-up the *id* with the max id of all *bitácoras*
        
        if let bitacoraWithMaxId = self.bitacoras.max(by: { bitacora1, bitacora2 in bitacora1.id < bitacora2.id
        }) {
            
            bitacoraToAdd.id = bitacoraWithMaxId.id + 1
            
        } else {
            
            // If there are not *bitácoras* the default *id* is 1
            bitacoraToAdd.id = 1
            
        }
        
        // Set-up another attributes with default data
        
        bitacoraToAdd.title = "Untitled"
        bitacoraToAdd.details = "No details"
        bitacoraToAdd.createAt = Date.now
        bitacoraToAdd.latitude = NSDecimalNumber(decimal: lat)
        bitacoraToAdd.longitude = NSDecimalNumber(decimal: lon)
        bitacoraToAdd.updateAt = nil
        
        // Save the context and update *bitácoras* and so
        
        do {
            try context.save()
            self.loadBitacoras()
            self.selectBitacora(byId: Int(bitacoraToAdd.id))
        } catch {
            context.rollback()
            // TODO: Notify error (bitacora cannot create)
        }
        
    }
    
    /// Update the current selected *bitácora* if the are some fields
    func updateSelectedBitacora(title: String?, details: String?) {
        
        // Create new instance of *BitacoraStatusEntity* in the current container-context
        
        let context = self.container.viewContext
        
        // Ask for the current selected *bitácora*
        
        if let bitacoraSelected = self.bitacoraSelected {
            
            // Record if updated has succeded
            
            var updated = false
            
            // Update the title if necessary
            
            if let title = title {
                bitacoraSelected.title = title
                updated = true
            }
            
            // Update the details if necessary
            
            if let details = details {
                bitacoraSelected.details = details
                updated = true
            }
            
            // If there are some update
            
            if updated {
                
                // Update and save the context
                
                bitacoraSelected.updateAt = Date.now
                
                do {
                    try context.save()
                    self.loadBitacoras()
                } catch {
                    context.rollback()
                    // TODO: Notify error (bitacora cannot update)
                }
                
            } else {
                // TODO: Notify error (bitacora nothing to update)
            }
            
        } else {
            // TODO: Notify error (bitacora not found)
        }
        
    }
    
    /// Create new *status of selected bitácora* with *label* and *status*
    func addStatusInSelectedBitacora(label: String, status: String) {
        
        // Create new *status of current selected bitácora*
        
        if let bitacoraSelected = self.bitacoraSelected {
            
            let context = self.container.viewContext
            
            // Create and set-up the new *status*
            
            let statusToAdd = BitacoraStatusEntity(context: context)
            
            statusToAdd.bitactora = bitacoraSelected
            statusToAdd.label = label
            statusToAdd.status = status
            
            // Save and notify as necessary
            
            do {
                try context.save()
                self.selectBitacora(byId: Int(bitacoraSelected.id))
                //self.loadStatusOfBitacoras()
            } catch {
                context.rollback()
                // TODO: Notify error (bitacora cannot create)
            }
            
        } else {
            // TODO: Notify error (bitacora not selected)
        }
        
    }
    
}

