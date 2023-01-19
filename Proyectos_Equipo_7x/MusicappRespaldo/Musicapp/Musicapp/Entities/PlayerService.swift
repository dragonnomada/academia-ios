//
//  PlayerService.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import AVFoundation
import Combine

class PlayerService {
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var songs: [SongEntity] = []
    
    var songPlayed: SongEntity?
    
    var isAudioLoading: Bool = false
    var isPlaying: Bool = false
    var isShuffle: Bool = false
    var isRepeating: Bool = false
    var isLocked: Bool = false
    var isPaused: Bool = false
    var isLoaded: Bool = false
    var isLoading: Bool = false
    var isReady: Bool = false
    
    var songsFetched = PassthroughSubject<[SongEntity], Never>()
    
}
