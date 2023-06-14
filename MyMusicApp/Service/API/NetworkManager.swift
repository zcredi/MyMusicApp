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
                completion(.success(musicModel.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
