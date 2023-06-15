//
//  MusicModel.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

struct MusicModel1: Codable {
    let feed: Feed1
}

struct Feed1: Codable {
    let title: String
    var results: [MusicResult1]
}

struct MusicResult1: Codable {
    let artistName, id, name, releaseDate, kind, artistId, artistUrl: String
    let contentAdvisoryRating: String?
    let genres: [Genre1]
    var artworkUrl100: String
    let url: String
}

struct Genre1: Codable {
  let genreId, name, url: String
}

struct AlbumResponse1: Codable {
  let feed: AlbumFeed1
}

struct AlbumFeed1: Codable {
  let results: [Album1]
}

struct Album1: Codable {
  let artistName: String
  let id: String
  let name: String
  let releaseDate: String
  let kind: String
  let artistId: String
  let artistUrl: String
  let contentAdvisoryRating: String?
  var artworkUrl100: String
  let genres: [Genre1]
  let url: String
}


struct Author1: Codable {
  let name: String
  let url: String
}

struct Link1: Codable {
  let selfLink: String

  enum CodingKeys1: String, CodingKey {
    case selfLink = "self"
  }
}
