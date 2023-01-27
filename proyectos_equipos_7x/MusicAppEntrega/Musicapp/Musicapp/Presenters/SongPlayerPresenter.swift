//
//  SongPlayerPresenter.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import Combine

class SongPlayerPresenter {
    
    weak var router: SongsRouter?
    
    weak var interactor: SongInteractor?
    
    var view: SongPlayerView?
    
    var songInfoSubscriber: AnyCancellable?
    var songTimeSubscriber: AnyCancellable?
    var songPlayingSubscriber: AnyCancellable?
    
    func start(router: SongsRouter, interactor: SongInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = SongPlayerViewController()
        
        self.view?.presenter = self
        
        self.songInfoSubscriber = interactor.songInfoSubject.sink {
            
            [weak self] song in
            
            print("RECIBIENDO INFO DE LA CANCIÓN \(song)")
            
            self?.view?.player(songInfo: song)
            
        }
        
        self.songTimeSubscriber = interactor.songTimeSubject.sink {
            
            [weak self] (time, duration, progress) in
            
            self?.view?.player(currentTime: time, duration: duration, progress: progress)
            
        }
        
        self.songPlayingSubscriber = interactor.songPlayingSubject.sink {
            
            [weak self] isPlaying in
            
            self?.view?.player(isPlaying: isPlaying)
            
        }
        
    }
    
    func stop() {
        
        self.songInfoSubscriber?.cancel()
        self.songInfoSubscriber = nil
        self.songTimeSubscriber?.cancel()
        self.songTimeSubscriber = nil
        self.songPlayingSubscriber?.cancel()
        self.songPlayingSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    func requestSongInfo() {
        
        print(self.interactor != nil ? "CON INTERACTOR" : "SIN INTERACTOR")
        
        self.interactor?.requestSongInfo()
        
    }
    
    func requestSongIsPlaying() {
        self.interactor?.requestSongIsPlaying()
    }
    
    func togglePlay() {
        
        self.interactor?.togglePlay()
        
    }
    
    deinit {
        print("El presentador SongInfoPresenter ha sido liberado")
    }
    
}
