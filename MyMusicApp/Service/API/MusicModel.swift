//
//  MusicModel.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

struct MusicModel: Codable {
    let results: [MusicResult]
}

struct MusicResult: Codable {
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String
}

