//
//  NetworkManager.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

import Foundation

protocol NetworkServiceProtocol {
  func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult], Error>) -> Void)
}

enum NetworkError: Error {
  case invalidKeyword
  case invalidURL
  case noData
}

final class NetworkService: NetworkServiceProtocol {
  func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult], Error>) -> Void) {
    guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      completion(.failure(NetworkError.invalidKeyword))
      return
    }
    
    let urlString = "https://itunes.apple.com/search?term=\(encodedKeyword)"
    
    guard let url = URL(string: urlString) else {
      completion(.failure(NetworkError.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NetworkError.noData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let musicModel = try decoder.decode(MusicModel.self, from: data)
        completion(.success(musicModel.feed.results))
      } catch {
        completion(.failure(error))
        
      }
    }
    task.resume()
  }
  
  func fetchTopMusic(completion: @escaping (Result<[MusicResult], Error>) -> Void) {
    let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/songs.json"

    guard let url = URL(string: urlString) else {
      completion(.failure(NetworkError.invalidURL))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(NetworkError.noData))
        return
      }

      do {
        let decoder = JSONDecoder()
        let musicModel = try decoder.decode(MusicModel.self, from: data)

        var modifiedResults = musicModel.feed.results

        for i in 0..<modifiedResults.count {
          modifiedResults[i].artworkUrl100 = modifiedResults[i].artworkUrl100.replacingOccurrences(
            of: "/100x100bb.jpg",
            with: "/600x600bb.jpg"
          )
        }
        var modifiedFeed = musicModel.feed
        modifiedFeed.results = modifiedResults
        let modifiedMusicModel = MusicModel(feed: modifiedFeed)
        completion(.success(modifiedMusicModel.feed.results))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  func fetchTopAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
    let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json")!

    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(NetworkError.noData))
        return
      }

      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(AlbumResponse.self, from: data)
        var modifiedAlbums = response.feed.results
        for i in 0..<modifiedAlbums.count {
          modifiedAlbums[i].artworkUrl100 = modifiedAlbums[i].artworkUrl100.replacingOccurrences(
            of: "/100x100bb.jpg",
            with: "/600x600bb.jpg"
          )
        }
        completion(.success(modifiedAlbums))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
