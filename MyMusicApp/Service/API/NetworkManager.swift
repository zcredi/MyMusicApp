//
//  NetworkManager.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

import Foundation

enum NetworkError: Error {
  case invalidKeyword
  case invalidURL
  case noData
}

final class NetworkService {
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
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let musicModel = try decoder.decode(MusicModel.self, from: data)

                let modifiedResults = musicModel.results.map { result in
                    var modifiedResult = result
                    modifiedResult.artworkUrl100 = modifiedResult.artworkUrl100.replacingOccurrences(
                        of: "/100x100bb.jpg",
                        with: "/600x600bb.jpg"
                    )
                    return modifiedResult
                }

                completion(.success(modifiedResults))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func fetchMusicDataFromAPI(urlString: String, completion: @escaping (Result<MusicResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(MusicResponse.self, from: data)

                let modifiedEntries = decodedData.feed.entry.map { entry in
                    var modifiedEntry = entry
                    modifiedEntry.images = modifiedEntry.images.map { image in
                        var modifiedImage = image
                        modifiedImage.label = modifiedImage.label.replacingOccurrences(of: "/170x170bb", with: "/600x600bb")
                        return modifiedImage
                    }
                    return modifiedEntry
                }

                let modifiedResponse = MusicResponse(feed: Feed(entry: modifiedEntries))

                completion(.success(modifiedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchAlbumDataFromAPI(urlString: String, completion: @escaping (Result<AlbumResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(AlbumResponse.self, from: data)

                let modifiedEntries = decodedData.feed.entry.map { entry in
                    var modifiedEntry = entry
                    modifiedEntry.images = modifiedEntry.images.map { image in
                        var modifiedImage = image
                        modifiedImage.label = modifiedImage.label.replacingOccurrences(of: "/170x170bb", with: "/600x600bb")
                        return modifiedImage
                    }
                    return modifiedEntry
                }

                let modifiedResponse = AlbumResponse(feed: AlbumFeed(entry: modifiedEntries))

                completion(.success(modifiedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
