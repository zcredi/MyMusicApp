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

  enum PlayerType {
    case musicResults
    case musicSearch
  }

  static let instance = MusicPlayer()

  weak var songController: SongViewControllerProtocol?
  weak var delegate: MusicPlayerDelegate?
  private var player: AVPlayer?
  private var playerItem: AVPlayerItem?
  var currentURL: String?
  private var currentSongIndex: Int = 0
  var musicModel: SongInfo? {
    didSet {
      if let musicModel = musicModel {
        songController?.configurateView(model: musicModel.model, image: musicModel.image)
      }
    }
  }

  private var currentPlayerType: PlayerType = .musicResults

  func loadPlayer(from url: String, playerType: PlayerType) {
    guard let musicURL = URL(string: url) else {
      print("Invalid music URL")
      return
    }

    currentPlayerType = playerType

    playerItem = AVPlayerItem(url: musicURL)
    player = AVPlayer(playerItem: playerItem)
    player?.play()
    currentURL = url
    delegate?.updatePlayButtonState(isPlaying: true)
    delegate?.updateCurrentURL(url)
    songController?.setDurationTime()
    songController?.updateButtonImage(isPlay: true)
    updatePlayerValues()
  }

  func loadPlayerForMusicResults(from url: String) {
    let musicPlayer = MusicPlayer.instance
    musicPlayer.delegate = self
    musicPlayer.loadPlayer(from: url, playerType: .musicResults)
  }

  private func loadPlayerForMusicSearch(from url: String) {
    let musicPlayer = MusicPlayer.instance
    musicPlayer.delegate = self
    musicPlayer.loadPlayer(from: url, playerType: .musicSearch)
    
  }

  func playMusicWithURL(_ url: String, playerType: PlayerType) {
      if isPlayingMusic(from: url) {
          pauseMusic()
      } else {
          loadPlayer(from: url, playerType: playerType)
          currentURL = url
      }
  }

  func playMusic() {
    player?.play()
    delegate?.updatePlayButtonState(isPlaying: true)
    songController?.updateButtonImage(isPlay: true)
  }

  func pauseMusic() {
    player?.pause()
    delegate?.updatePlayButtonState(isPlaying: false)
    songController?.updateButtonImage(isPlay: false)
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

  func isPlayerPerforming() -> Bool {
    player?.timeControlStatus == .playing ? true : false
  }

  func getTrackDuration() -> Double {
    guard let duration = player?.currentItem?.asset.duration else { return 0 }

    return duration.seconds
  }

  func updatePlayerValues() {
    player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60),
                                    queue: DispatchQueue.main) { [weak self] CMTime in
      guard let self = self else { return }
      songController?.updateSlider(value: Float(CMTime.seconds))
      songController?.updateCurrentTimeLabel(duration: Int(CMTime.seconds))
    }
  }

  func rewindTrack(at time: Float) {
    player?.seek(to: CMTime(seconds: Double(time), preferredTimescale: 1000))
  }

  func playNextSong() {
    switch currentPlayerType {
    case .musicResults:
      playNextSongForMusicResults()
    case .musicSearch:
      playNextSongForMusicSearch()
    }
  }

  private func playNextSongForMusicResults() {
    currentSongIndex += 1

    if currentSongIndex >= Music.shared.musicResults.count {
      currentSongIndex = 0
    }

    if let currentIndex = Music.shared.musicResults.firstIndex(where: { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href == currentURL }) {
      let nextIndex = (currentIndex + 1) % Music.shared.musicResults.count
      if let nextURL = Music.shared.musicResults[nextIndex].links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
        loadPlayer(from: nextURL, playerType: .musicResults)
      }
    }
    songController?.setDurationTime()
    updatePlayerValues()
  }

   func playNextSongForMusicSearch() {
    currentSongIndex += 1

    if currentSongIndex >= Music.shared.musicSearch.count {
      currentSongIndex = 0
    }

    if let currentIndex = Music.shared.musicSearch.firstIndex(where: { $0.previewUrl == currentURL }) {
      let nextIndex = (currentIndex + 1) % Music.shared.musicSearch.count
      if let nextURL = Music.shared.musicSearch[nextIndex].previewUrl {
        loadPlayer(from: nextURL, playerType: .musicSearch)
      }
    }
    songController?.setDurationTime()
    updatePlayerValues()
  }

  func playPreviousSong() {
    switch currentPlayerType {
    case .musicResults:
      playPreviousSongForMusicResults()
    case .musicSearch:
      playPreviousSongForMusicSearch()
    }
  }

   func playPreviousSongForMusicResults() {
    currentSongIndex -= 1

    if currentSongIndex < 0 {
      currentSongIndex = Music.shared.musicResults.count - 1
    }

    if let currentIndex = Music.shared.musicResults.firstIndex(where: { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href == currentURL }) {
      let previousIndex = (currentIndex - 1 + Music.shared.musicResults.count) % Music.shared.musicResults.count
      if let previousURL = Music.shared.musicResults[previousIndex].links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
        loadPlayer(from: previousURL, playerType: .musicResults)
      }
    }

    songController?.setDurationTime()
    updatePlayerValues()
  }

  func playPreviousSongForMusicSearch() {
      currentSongIndex -= 1
      if currentSongIndex < 0 {
          currentSongIndex = Music.shared.musicSearch.count - 1
      }

      if let currentIndex = Music.shared.musicSearch.firstIndex(where: { $0.previewUrl == currentURL }) {
          let previousIndex = (currentIndex - 1 + Music.shared.musicSearch.count) % Music.shared.musicSearch.count
          if let previousURL = Music.shared.musicSearch[previousIndex].previewUrl {
              loadPlayer(from: previousURL, playerType: .musicSearch)
          }
      }

      songController?.setDurationTime()
      updatePlayerValues()
  }

  func updateMusicResults(_ results: [Entry]) {
    Music.shared.musicResults = results
    currentSongIndex = 0
  }
}

extension MusicPlayer: MusicPlayerDelegate {
  func updatePlayButtonState(isPlaying: Bool) {
    delegate?.updatePlayButtonState(isPlaying: isPlaying)
  }

  func updateCurrentURL(_ url: String) {
    delegate?.updateCurrentURL(url)
  }
}
