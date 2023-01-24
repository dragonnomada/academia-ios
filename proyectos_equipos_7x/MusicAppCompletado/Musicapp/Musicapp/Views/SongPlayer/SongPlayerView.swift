//
//  SongPlayerView.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation

protocol SongPlayerView: NSObject {
    
    var presenter: SongPlayerPresenter? { get set }
    
    func player(isPlaying: Bool)
    
    func player(songInfo song: SongEntity)
    
    func player(currentTime time: Int, duration: Int, progress: Double)
    
}
