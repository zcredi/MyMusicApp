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
  var images: [Image]
  let links: [Link]
  let category: Category
  
  private enum CodingKeys: String, CodingKey {
    case name = "im:name"
    case images = "im:image"
    case links = "link"
    case artist = "im:artist"
    case category
  }
  
  private enum LinkCodingKeys: String, CodingKey {
    case attributes
  }
  
  private enum ImageSize: String {
    case size170 = "170x170bb"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(Name.self, forKey: .name)
    artist = try container.decode(Artist.self, forKey: .artist)
    
    let imagesContainer = try container.decode([Image].self, forKey: .images)
    images = imagesContainer.filter { $0.label.contains(ImageSize.size170.rawValue) }
    
    if let linksContainer = try? container.nestedContainer(keyedBy: LinkCodingKeys.self, forKey: .links) {
      do {
        let linkAttributes = try linksContainer.decode(Link.self, forKey: .attributes)
        links = [linkAttributes]
      } catch {
        links = []
      }
    } else if let linksArrayContainer = try? container.decode([Link].self, forKey: .links) {
      links = linksArrayContainer
    } else {
      links = []
    }
    category = try container.decode(Category.self, forKey: .category)
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
  var label: String
} 
struct Category: Decodable {
    let attributes: CategoryAttributes
}

struct CategoryAttributes: Decodable {
    let term: String
    let label: String
}
struct AlbumResponse: Decodable {
  let feed: AlbumFeed
}

struct AlbumFeed: Decodable {
  let entry: [AlbumEntry]
}

struct AlbumEntry: Decodable {
  let name: Name
  let artist: Artist
  var images: [Image]
  let links: [Link]
  
  private enum CodingKeys: String, CodingKey {
    case name = "im:name"
    case images = "im:image"
    case link
    case artist = "im:artist"
  }
  
  private enum LinkCodingKeys: String, CodingKey {
    case attributes
  }
  
  private enum ImageSize: String {
    case size170 = "170x170bb"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(Name.self, forKey: .name)
    artist = try container.decode(Artist.self, forKey: .artist)
    
    let imagesContainer = try container.decode([Image].self, forKey: .images)
    images = imagesContainer.filter { $0.label.contains(ImageSize.size170.rawValue) }
    
    if let linksContainer = try? container.nestedContainer(keyedBy: LinkCodingKeys.self, forKey: .link) {
      do {
        let linkAttributes = try linksContainer.decode(Link.self, forKey: .attributes)
        links = [linkAttributes]
      } catch {
        links = []
      }
    } else if let linksArrayContainer = try? container.decode([Link].self, forKey: .link) {
      links = linksArrayContainer
    } else {
      links = []
    }
  }
}
