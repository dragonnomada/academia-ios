//
//  SongsHomePresenter.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import Combine

class SongsHomePresenter {
    
    weak var router: SongsRouter?
    
    weak var interactor: SongInteractor?
    
    var view: HomeView?
    
    var songsFetchedSubscriber: AnyCancellable?
    
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
        
    }
    
    func stop() {
        
        self.songsFetchedSubscriber?.cancel()
        self.songsFetchedSubscriber = nil
        
        self.router = nil
        self.interactor = nil
        self.view = nil
        
    }
    
    func requestSongs() {
        
        self.interactor?.requestSongs()
        
    }
    
    deinit {
        print("El presentador SongsHomePresenter ha sido liberado")
    }
    
}
