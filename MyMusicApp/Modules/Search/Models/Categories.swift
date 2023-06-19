//
//  Categories.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import Foundation

enum Categories {
    case all
    case artist
    case album
    case song
    case playlist
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .artist:
            return "Artist"
        case .album:
            return "Album"
        case .song:
            return "Song"
        case .playlist:
            return "Playlist"
        }
    }
}
