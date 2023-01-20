//
//  SongEntity.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation

enum SongGender: String, Decodable {
    
    case rock = "ROCK"
    case pop = "POP"
    case reggeton = "REGGETON"
    case ranchera = "RANCHERA"
    case trova = "TROVA"
    case banda = "BANDA"
    
}

struct SongEntity: Decodable {
    
    let id: Int
    let artist: String
    let album: String
    let title: String
    let track: Int
    let trackMax: Int
    let songUrl: String
    let pictureUrl: String
    var lyrics: String
    let gender: SongGender
    
}

struct SongsResponseEntity: Decodable {
    
    let songs: [SongEntity]
    
}

