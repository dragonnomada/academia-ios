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

class PlayerService: NSObject {
    
    // State
    
    private var player: AVPlayer?
    var playerStatus: AVPlayer.Status = .unknown
    private var playerItem: AVPlayerItem?
    
    private var songs: [SongEntity] = []
    private var songsPlayed: [SongEntity] = []
    private var songPlayed: SongEntity?
    private var songSelected: SongEntity?
    
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
    
    var songSelectedSubject = PassthroughSubject<SongEntity, Never>()
    var songInfoSubject = PassthroughSubject<SongEntity, Never>()
    var songPlayedSubject = PassthroughSubject<SongEntity, Never>()
    var songTimeSubject = PassthroughSubject<(time: Int, duration: Int, progress: Double), Never>()
    var songPlayingSubject = PassthroughSubject<Bool, Never>()
    
    deinit {
        
        if let player = self.player {
            
            player.removeObserver(self, forKeyPath: #keyPath(AVPlayer.status))
            
        }
        
    }
    
    // Transactions
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &self.playerStatus {
            
            //print(context)
            
            //print(keyPath)
            
            if keyPath == #keyPath(AVPlayer.status) {
                
                if let statusNumber = change?[.newKey] as? NSNumber {
                    
                    let status: AVPlayer.Status = AVPlayer.Status(rawValue: statusNumber.intValue) ?? .unknown
                    
                    print(status)
                    
                    switch status {
                    case .readyToPlay:
                        // TODO: Notificar que el reproductor está listo
                        print("Estatus del reproductor listo")
                        self.play()
                        self.isReady = true
                    case .failed:
                        print("Estatus del reproductor fallido")
                    case .unknown:
                        print("Estatus del reproductor desconocido")
                    default:
                        print("Estatus del reproductor no válido")
                    }
                    
                }
                
            }
        }
        
    }
    
    func createPlayer() {
        
        self.player = AVPlayer()
        
        if let player = self.player {
            player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.old, .new], context: &self.playerStatus)
            
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) {
                
                [weak self] _ in
                
                let seconds = player.currentTime().seconds
                
                print("SECONDS: \(seconds)")
                
                if !seconds.isInfinite && !seconds.isNaN {
                    
                    let time = Int(seconds)
                    
                    print("TIME: \(time)")
                    
                    self?.currentTime = time
                    
                    if let playerItem = self?.playerItem {
                        
                        let durationSeconds = playerItem.duration.seconds
                        
                        print("DURATION SECONDS: \(durationSeconds)")
                        
                        if !durationSeconds.isInfinite && !durationSeconds.isNaN {
                            
                            let duration = Int(durationSeconds)
                            
                            self?.currentDuration = duration
                            
                            let progress = Double(time) / Double(duration)
                            
                            print("PROGRESS: \(progress)")
                            
                            self?.songTimeSubject.send((time: time, duration: duration, progress: progress))
                            
                        }
                        
                    }
                    
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
            
        }).sorted(by: { $0.id < $1.id })
        
        // TODO: Notificar que las canciones fueron descargadas
        songsFetchedSubject.send(self.songs)
        
    }
    
    func requestPlayedSongInfo() {
        
    }
    
    func selectSong(byId: Int) {
        
        if let song = self.songs.filter({ $0.id == byId }).first {
            
            self.songSelected = song
            
            // ¿Quién escucha? HomePresenter
            self.songSelectedSubject.send(song)
            
        } else {
            // TODO: Error no existe la canción
            print("No existe la canción con id \(byId)")
        }
        
    }
    
    func requestSongInfo() {
        
        if let song = self.songSelected {
         
            // ¿Quién escucha? HomePresenter
            self.songInfoSubject.send(song)
            
        } else {
            
            // TODO: No hay canción seleccionada
            print("No hay canción seleccionada")
            
        }
        
    }
    
    func playSongSelected() {
        
        if let song = songSelected {
            
            self.songPlayed = song
            
            if let url = URL(string: song.songUrl) {
                self.playerItem = AVPlayerItem(url: url)
                
                self.player?.replaceCurrentItem(with: self.playerItem)
                
                self.isLoaded = true
                self.isLocked = false
                
                if let songPlayed = self.songPlayed {
                    self.songPlayedSubject.send(songPlayed)
                }
                
                if self.isReady {
                    self.player?.play()
                    self.isPlaying = true
                }
                
                // TODO: Notificar que la canción está lista (deprecated)
            }
            
        } else {
            
            // TODO: Error no hay canción seleccionada
            print("No hay canción seleccionada")
            
        }
        
    }
    
    func togglePlay() {
        
        if self.isPlaying {
            self.pause()
        } else {
            self.play()
        }
        
    }
    
    func requestSongIsPlaying() {
        self.songPlayingSubject.send(self.isPlaying)
    }
    
    func play() {
        self.player?.play()
        self.isPlaying = true
        self.isPaused = false
        self.songPlayingSubject.send(true)
        
    }
    
    func pause() {
        self.player?.pause()
        self.isPlaying = false
        self.isPaused = true
        self.songPlayingSubject.send(false)
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
