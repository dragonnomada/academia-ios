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
    
    lazy var songSelectedSubject: PassthroughSubject<SongEntity, Never> = {
        self.service.songSelectedSubject
    }()
    
    lazy var songInfoSubject: PassthroughSubject<SongEntity, Never> = {
        self.service.songInfoSubject
    }()
    
    lazy var songPlayedSubject: PassthroughSubject<SongEntity, Never> = {
        self.service.songPlayedSubject
    }()
    
    lazy var songPlayingSubject: PassthroughSubject<Bool, Never> = {
        self.service.songPlayingSubject
    }()
    
    lazy var songTimeSubject: PassthroughSubject<(time: Int, duration: Int, progress: Double), Never> = {
        self.service.songTimeSubject
    }()
    
    func requestSongs() {
        
        Task {
            
            await service.downloadSongs()
            
        }
    }
    
    func selectSong(song: SongEntity) {
        
        self.service.selectSong(byId: song.id)
        
    }
    
    func requestSongInfo() {
        
        self.service.requestSongInfo()
        
    }
    
    func requestSongIsPlaying() {
        self.service.requestSongIsPlaying()
    }
    
    func playSongSelected() {
        
        self.service.playSongSelected()
        
    }
    
    func togglePlay() {
        
        self.service.togglePlay()
        
    }
    
}
