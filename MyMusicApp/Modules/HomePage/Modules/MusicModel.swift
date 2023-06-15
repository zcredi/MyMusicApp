//
//  MusicModel.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

struct MusicModel: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    var results: [MusicResult]
}

struct MusicResult: Codable {
    let artistName, id, name, releaseDate, kind, artistId, artistUrl: String
    let contentAdvisoryRating: String?
    let genres: [Genre]
    var artworkUrl100: String
    let url: String
}

struct Genre: Codable {
  let genreId, name, url: String
}

struct AlbumResponse: Codable {
  let feed: AlbumFeed
}

struct AlbumFeed: Codable {
  let results: [Album]
}

struct Album: Codable {
  let artistName: String
  let id: String
  let name: String
  let releaseDate: String
  let kind: String
  let artistId: String
  let artistUrl: String
  let contentAdvisoryRating: String?
  var artworkUrl100: String
  let genres: [Genre]
  let url: String
}


struct Author: Codable {
  let name: String
  let url: String
}

struct Link: Codable {
  let selfLink: String
  
  enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }
}
