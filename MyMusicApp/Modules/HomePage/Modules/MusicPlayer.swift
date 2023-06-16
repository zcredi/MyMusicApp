//
//  MusicPlayer.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 15.06.2023.
//

import Foundation
import AVFoundation

class MusicPlayer {
  private var player: AVPlayer?
  var currentURL: String?
  private var musicResults: [Entry] = []
  private var currentSongIndex: Int = 0

  func playMusic(from url: String) {
    guard let musicURL = URL(string: url) else {
      print("Invalid music URL")
      return
    }

    if isPlayingMusic(from: url) {
      return
    }

    let playerItem = AVPlayerItem(url: musicURL)
    player = AVPlayer(playerItem: playerItem)
    player?.play()
    currentURL = url
  }

  func pauseMusic() {
    player?.pause()
  }

  func stopMusic() {
    player?.pause()
    player = nil
    currentURL = nil
  }

  func isPlayingMusic(from url: String) -> Bool {
    return currentURL == url && player?.rate != 0 && player?.error == nil
  }

  func playNextSong() {
    guard !musicResults.isEmpty else {
      return
    }

    currentSongIndex += 1

    if currentSongIndex >= musicResults.count {
      currentSongIndex = 0
    }

    let nextSong = musicResults[currentSongIndex]
    if let audioURL = nextSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
      playMusic(from: audioURL)
    }
  }

  func playPreviousSong() {
    guard !musicResults.isEmpty else {
      return
    }

    currentSongIndex -= 1

    if currentSongIndex < 0 {
      currentSongIndex = musicResults.count - 1
    }

    let previousSong = musicResults[currentSongIndex]
    if let audioURL = previousSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
      playMusic(from: audioURL)
    }
  }

  func updateMusicResults(_ results: [Entry]) {
    musicResults = results
  }
}
