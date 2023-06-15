//
//  tesr.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 15.06.2023.
//

import Foundation

struct MusicResponse: Decodable {
  let feed: Feed
}

struct Feed: Decodable {
  let entry: [Entry]
}

struct Entry: Decodable {
  let name: Name
  let artist: Artist
  let images: [Image]
  let links: [Link]
  
  private enum CodingKeys: String, CodingKey {
    case name = "im:name"
    case images = "im:image"
    case links = "link"
    case artist = "im:artist"
  }
}

struct Name: Decodable {
  let label: String
}

struct Artist: Decodable {
  let label: String
}

struct Link: Decodable {
  let attributes: LinkAttributes
}

struct LinkAttributes: Decodable {
  let rel: String
  let type: String?
  let href: String
}

struct Label: Decodable {
  let label: String
}

struct Image: Decodable {
  let label: String
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
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
