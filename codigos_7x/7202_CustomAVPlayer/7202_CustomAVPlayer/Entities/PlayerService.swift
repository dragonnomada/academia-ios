//
//  PlayerService.swift
//  7202_CustomAVPlayer
//
//  Created by Dragon on 17/01/23.
//

import Foundation
import AVFoundation
import Combine

class PlayerService {
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var songs: [SongEntity] = []
    
    var songPlayed: SongEntity?
    
    var isPlaying: Bool = false
    // ... (isPaused, isLoaded, isLoading, isReady, ...)
    
    var songsFetched = PassthroughSubject<[SongEntity], Never>()
    
}
