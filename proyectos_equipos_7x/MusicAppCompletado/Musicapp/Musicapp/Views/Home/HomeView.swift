//
//  HomeView.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation

protocol HomeView: NSObject {
    
    var presenter: SongsHomePresenter? { get set }
    
    func player(songsFetched songs: [SongEntity])
    
    func player(songsFetchedError error: SongsFetechedError)
    
    func player(songsSelected song: SongEntity)
    
}
