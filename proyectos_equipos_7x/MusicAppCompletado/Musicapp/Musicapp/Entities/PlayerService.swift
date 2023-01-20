//
//  PlayerService.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import AVFoundation
import Combine

enum SongsFetechedError: Error {
    
    case serverError(String)
    case badRequest
    case invalidUrl
    case invalidJson
    case other(String)
    
}

class PlayerService {
    
    // State
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    private var songs: [SongEntity] = []
    private var songsPlayed: [SongEntity] = []
    private var songPlayed: SongEntity?
    
    private var currentTime: Int = 0
    private var currentDuration: Int = 0
    
    private var isPlaying: Bool = false
    private var isShuffle: Bool = false
    private var isRepeating: Bool = false
    private var isLocked: Bool = false
    private var isPaused: Bool = false
    private var isLoaded: Bool = false
    private var isLoading: Bool = false
    private var isReady: Bool = false
    
    // Notificators
    
    var songsFetchedSubject = PassthroughSubject<[SongEntity], SongsFetechedError>()
    
    // Transactions
    
    func createPlayer() {
        
        self.player = AVPlayer()
        
        if let player = self.player {
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) {
                
                [weak self] _ in
                
                let seconds = player.currentTime().seconds
                
                if !seconds.isFinite && !seconds.isNaN {
                    
                    self?.currentTime = Int(seconds)
                    
                    // TODO: Notificar a la vista que currentTime cambió
                    
                }
                
            }
            
        }
        
    }
    
    func downloadSongs() async {
        
        print("Download songs from API")
        
        guard let url = URL(string: "http://34.125.242.89/api/musicapp/songs") else {
            
            // TODO: Notificar que la URL no es válida
            songsFetchedSubject.send(completion: .failure(.invalidUrl))
            
            return
            
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            
            // TODO: Notificar que hubo error en la petición
            songsFetchedSubject.send(completion: .failure(.serverError("Unknown")))
            
            return
            
        }
        
        guard let songsResponse = try? JSONDecoder().decode(SongsResponseEntity.self, from: data) else {
            
            // TODO: Notificar que hubo un error al decodificar las canciones
            songsFetchedSubject.send(completion: .failure(.invalidJson))
            
            return
            
        }
        
        self.songs = songsResponse.songs.map({
            
            song in
            
            var songCopy = song
            
            if let data = Data(base64Encoded: songCopy.lyrics) {
                if let lyricsUtf8 = String(data: data, encoding: .utf8) {
                    songCopy.lyrics = lyricsUtf8
                }
            }
            
            return songCopy
            
        })
        
        // TODO: Notificar que las canciones fueron descargadas
        songsFetchedSubject.send(self.songs)
        
    }
    
    func requestPlayedSongInfo() {
        
    }
    
    func selectSong(byId: Int) {
        
    }
    
    func play() {
        
    }
    
    func pause() {
        
    }
    
    func backward() {
        
    }
    
    func forward() {
        
    }
    
    func activeRepeat() {
        
    }
    
    func deactivateRepeate() {
        
    }
    
    func activeShuffle() {
        
    }
    
    func deactiveShuffle() {
        
    }
    
    
    
}
