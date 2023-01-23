//
//  SongsHomePresenter.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import Combine

class SongsHomePresenter {
    
    private weak var router: SongsRouter?
    
    private weak var interactor: SongInteractor?
    
    var view: HomeView?
    
    var songsFetchedSubscriber: AnyCancellable?
    var songSelectedSubscriber: AnyCancellable?
    
    func start(router: SongsRouter, interactor: SongInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = HomeViewController()
        
        self.view?.presenter = self
        
        self.songsFetchedSubscriber = interactor.songsFetchedSubject.sink(receiveCompletion: {
            
            [weak self] completion in
            
            switch completion {
                
            case .failure(let error):
                DispatchQueue.main.async {
                    
                    [weak self] in
                    
                    self?.view?.player(songsFetchedError: error)
                    
                }
                
            case .finished:
                fatalError("No se esperaba que este sujeto finalizara")
                
            }
            
        }, receiveValue: {
            
            [weak self] songs in
            
            DispatchQueue.main.async {
                
                [weak self] in
                
                self?.view?.player(songsFetched: songs)
                
            }
            
        })
        
        self.songSelectedSubscriber = interactor.songSelectedSubject.sink {
            
            [weak self] song in
            
            self?.view?.player(songsSelected: song)
            
        }
        
    }
    
    func stop() {
        
        self.songsFetchedSubscriber?.cancel()
        self.songsFetchedSubscriber = nil
        
        self.songSelectedSubscriber?.cancel()
        self.songSelectedSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    func requestSongs() {
        
        self.interactor?.requestSongs()
        
    }
    
    func selectSong(song: SongEntity) {
        
        self.interactor?.selectSong(song: song)
        
    }
    
    func goToSongInfo() {
        self.router?.goToSongInfo()
    }
    
    deinit {
        print("El presentador SongsHomePresenter ha sido liberado")
    }
    
}
