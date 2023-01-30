//
//  ProfileEditViewDelegatee.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation

protocol ProfileEditViewDelegate {
    var presenter: ProfileEditPresenter? { get set }
    
    func profile(profileSelected profile: ProfileEntity)
    func profile(profileUpdated profile: ProfileEntity)
}

