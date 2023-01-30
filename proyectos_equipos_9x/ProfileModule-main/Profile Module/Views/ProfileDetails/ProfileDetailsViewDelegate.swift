//
//  ProfieDetailsViewDelegate.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation

protocol ProfileDetailsViewDelegate {
    var presenter: ProfileDetailsPresenter? { get set }
    
    func profile(profileCreated profile: ProfileEntity)
}
