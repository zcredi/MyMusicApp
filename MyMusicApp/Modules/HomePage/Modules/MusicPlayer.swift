//
//  MusicPlayer.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 15.06.2023.
//

import Foundation
import AVFoundation

protocol MusicPlayerDelegate: AnyObject {
    func updatePlayButtonState(isPlaying: Bool)
    func updateCurrentURL(_ url: String)
}

class MusicPlayer {
  weak var delegate: MusicPlayerDelegate?

  private var player: AVPlayer?
  private var playerItem: AVPlayerItem?
  var currentURL: String?
  private var currentSongIndex: Int = 0

  func playMusic(from url: String) {
    guard let musicURL = URL(string: url) else {
      print("Invalid music URL")
      return
    }

    if isPlayingMusic(from: url) {
      return
    }

    if let playerItem = playerItem {
      player?.replaceCurrentItem(with: playerItem)
    } else {
      playerItem = AVPlayerItem(url: musicURL)
      player = AVPlayer(playerItem: playerItem)
    }

    player?.play()
    currentURL = url
    delegate?.updatePlayButtonState(isPlaying: true)
    delegate?.updateCurrentURL(url)
    print(Music.shared.musicResults.count)
    print(currentSongIndex)
  }

  func pauseMusic() {
    player?.pause()
    delegate?.updatePlayButtonState(isPlaying: false)
  }

  func stopMusic() {
    player?.pause()
    player = nil
    currentURL = nil
    delegate?.updatePlayButtonState(isPlaying: false)
    delegate?.updateCurrentURL("")
  }

  func isPlayingMusic(from url: String) -> Bool {
    return currentURL == url && player?.rate != 0 && player?.error == nil
  }

  func playNextSong() {
    currentSongIndex += 1

    if currentSongIndex >= Music.shared.musicResults.count {
      currentSongIndex = 0
    }

    if let currentIndex = musicResults.firstIndex(where: { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href == currentURL }) {
      let nextIndex = (currentIndex + 1) % musicResults.count
      let nextURL = musicResults[nextIndex].links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href
      updateCurrentURL(nextURL)
    }
  }

  func playPreviousSong() {
    currentSongIndex -= 1

    if currentSongIndex < 0 {
      currentSongIndex = Music.shared.musicResults.count - 1
    }

    if let currentIndex = musicResults.firstIndex(where: { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href == currentURL }) {
      let previousIndex = (currentIndex - 1 + musicResults.count) % musicResults.count
      let previousURL = musicResults[previousIndex].links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href
      updateCurrentURL(previousURL)
    }
  }

  func updateMusicResults(_ results: [Entry]) {
    Music.shared.musicResults = results
    currentSongIndex = 0
  }
}
