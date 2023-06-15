//
//  NetworkManager.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

import Foundation

protocol NetworkServiceProtocol {
  func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult1], Error>) -> Void)
}

enum NetworkError: Error {
  case invalidKeyword
  case invalidURL
  case noData
}

final class NetworkService: NetworkServiceProtocol {
  func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult1], Error>) -> Void) {
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
        let musicModel = try decoder.decode(MusicModel1.self, from: data)
        completion(.success(musicModel.feed.results))
      } catch {
        completion(.failure(error))
        
      }
    }
    task.resume()
  }
  
  func fetchTopMusic(completion: @escaping (Result<[MusicResult1], Error>) -> Void) {
    let urlString = "https://itunes.apple.com/us/rss/topsongs/limit=10/json"

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
        let musicModel = try decoder.decode(MusicModel1.self, from: data)

        var modifiedResults = musicModel.feed.results

        for i in 0..<modifiedResults.count {
          modifiedResults[i].artworkUrl100 = modifiedResults[i].artworkUrl100.replacingOccurrences(
            of: "/100x100bb.jpg",
            with: "/600x600bb.jpg"
          )
        }
        var modifiedFeed = musicModel.feed
        modifiedFeed.results = modifiedResults
        let modifiedMusicModel = MusicModel1(feed: modifiedFeed)
        completion(.success(modifiedMusicModel.feed.results))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  func fetchTopAlbums(completion: @escaping (Result<[Album1], Error>) -> Void) {
    let url = URL(string: "https://itunes.apple.com/us/rss/topalbums/limit=10/json")!

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
        let response = try decoder.decode(AlbumResponse1.self, from: data)
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
