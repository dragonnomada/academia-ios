//
//  BitacoraDetailsView.swift
//  BitacorAPP
//
//  Created by Dragon on 12/01/23.
//
//  Mantained by Alan Badillo Salas
//
//  Changes:
//  * [12/01/23] Definition of BitacoraDetailsView protocol
//  * [12/01/23] Add current selected bitácora updated notification
//

import Foundation

/// Protocol needed by view-controllers with data notifiers from view-models
protocol BitacoraDetailsView: NSObject {
    
    // FUNCTIONS WITH DATA NOTIFIERS FROM VIEW-MODEL
    
    /// Receive the *current selected bitácora* when it changes or made request
    func bitacora(bitacoraSelected bitacora: BitacoraEntity)
    
    /// Receive the list of *status of current selected bitácora* when it changes or made request
    func bitacora(statusOfBitacoraSelected status: [BitacoraStatusEntity])
    
    /// Receive the *current selected bitácora* when its finally update
    func bitacora(bitacoraUpdated bitacora: BitacoraEntity)
    
}
