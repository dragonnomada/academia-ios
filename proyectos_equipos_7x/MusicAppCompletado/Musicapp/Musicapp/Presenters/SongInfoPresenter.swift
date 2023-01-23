//
//  SongInfoPresenter.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import Combine

class SongInfoPresenter {
    
    weak var router: SongsRouter?
    
    weak var interactor: SongInteractor?
    
    var view: SongInfoView?
    
    var songInfoSubscriber: AnyCancellable?
    
    func start(router: SongsRouter, interactor: SongInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = SongInfoViewController()
        
        self.view?.presenter = self
        
        self.songInfoSubscriber = interactor.songInfoSubject.sink {
            
            [weak self] song in
            
            print("RECIBIENDO INFO DE LA CANCIÓN \(song)")
            
            self?.view?.player(songsSelected: song)
            
        }
        
    }
    
    func stop() {
        
        self.songInfoSubscriber?.cancel()
        self.songInfoSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    func requestSongInfo() {
        
        print(self.interactor != nil ? "CON INTERACTOR" : "SIN INTERACTOR")
        
        self.interactor?.requestSongInfo()
        
    }
    
    func play() {
        
        self.interactor?.playSongSelected()
        
    }
    
    deinit {
        print("El presentador SongInfoPresenter ha sido liberado")
    }
    
}
