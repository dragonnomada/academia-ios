//
//  SongsInteractor.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import Combine

class SongInteractor {
    
    private lazy var service: PlayerService = {
        
        let service = PlayerService()
        
        service.createPlayer()
        
        return service
        
    }()
    
    // replica
    lazy var songsFetchedSubject: PassthroughSubject<[SongEntity], SongsFetechedError> = {
        self.service.songsFetchedSubject
    }()
    
    func requestSongs() {
        
        Task {
            
            await service.downloadSongs()
            
        }
    }
    
}
