//
//  SongInfoView.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation

protocol SongInfoView: NSObject {
    
    var presenter: SongInfoPresenter? { get set }
    
    func player(songsSelected song: SongEntity)
    
    func player(songsPlayed song: SongEntity)
    
}
