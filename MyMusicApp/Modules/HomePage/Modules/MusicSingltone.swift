//
//  MusicSingltone.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 20.06.2023.
//

import Foundation
class Music {
  static let shared = Music()
  var musicResults: [Entry] = []
  var musicSearch: [MusicResult] = []
  var albumResults: [AlbumEntry] = []
}
