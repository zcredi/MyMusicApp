//
//  AlbumDetail.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 21.06.2023.
//

import UIKit
import AVFoundation

class AlbumDetailViewController: UIViewController {

  var songs: [MusicResult] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  private var player: AVPlayer?
  private var currentItem: AVPlayerItem?
  private var initialTouchPoint: CGPoint = CGPoint.zero
  private let musicPlayer = MusicPlayerS()
  private let miniPlayerVC = MiniPlayerVC()

  private lazy var tableView: UITableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.backgroundColor = .white
      tableView.register(AlbumDetailCell.self, forCellReuseIdentifier: AlbumDetailCell.identifier)

      return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTable()
    setupConstraints()
    miniPlayerVC.delegate = self
    musicPlayer.delegate = self

    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    view.addGestureRecognizer(panGestureRecognizer)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  func showMiniPlayer() {
    miniPlayerVC.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(miniPlayerVC)
    NSLayoutConstraint.activate([
      miniPlayerVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      miniPlayerVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      miniPlayerVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
      miniPlayerVC.heightAnchor.constraint(equalToConstant: 70)
    ])
  }

  func configureTable() {
    tableView.rowHeight = 60
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.dataSource = self
    tableView.delegate = self
  }

  private func setupConstraints() {
    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  func update(with musicResults: [MusicResult]) {
    songs = musicResults
  }

  private func playMusic(url: URL) {
    player?.pause()

    let playerItem = AVPlayerItem(url: url)
    currentItem = playerItem
    player = AVPlayer(playerItem: playerItem)
    player?.play()
  }

  @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
      let touchPoint = gestureRecognizer.location(in: self.view?.window)

      switch gestureRecognizer.state {
      case .began:
        initialTouchPoint = touchPoint
      case .changed:
        if touchPoint.x - initialTouchPoint.x > 0 {
          view.frame = CGRect(x: touchPoint.x - initialTouchPoint.x, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
      case .ended, .cancelled:
        if touchPoint.x - initialTouchPoint.x > 200 {
          dismiss(animated: true, completion: nil)
        } else {
          UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
          }
        }
      default:
        break
      }
    }
}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songs.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailCell.identifier, for: indexPath) as? AlbumDetailCell else {
      return UITableViewCell()
    }
    let songNumber = indexPath.row + 1
    cell.configureCell(with: songs[indexPath.row], songNumber: songNumber)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let musicUrlString = songs[indexPath.row].previewUrl else {
          return
      }
      showMiniPlayer()
      updateCurrentURL(musicUrlString)

    if musicPlayer.isPlayingMusic(from: musicUrlString) {
      musicPlayer.pauseMusic()
    } else {
      musicPlayer.playMusic(from: musicUrlString)
    }
  }
}

extension AlbumDetailViewController: MiniPlayerViewDelegate {
  func forwardButtonTapped() {
    musicPlayer.playNextSong()
  }

  func backwardButtonTapped() {
    musicPlayer.playPreviousSong()
  }

  func playButtonTapped() {
    musicPlayer.pauseMusic()
  }

}

extension AlbumDetailViewController: MusicPlayerDelegate {

  func updateCurrentURL(_ url: String) {
    guard let musicResult = getMusicResultFromURL(url) else {
      miniPlayerVC.updateSongTitle("")
      miniPlayerVC.updateSongImage(nil)
      return
    }
    miniPlayerVC.updateSongTitle(musicResult.trackName ?? "")
    if let imageUrl = URL(string: musicResult.artworkUrl100), !url.isEmpty {
      URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        DispatchQueue.main.async {
          if let imageData = data, let image = UIImage(data: imageData) {
            self.miniPlayerVC.updateSongImage(image)
          } else {
            self.miniPlayerVC.updateSongImage(nil)
          }
        }
      }.resume()
    } else {
      miniPlayerVC.updateSongImage(nil)
    }
  }

  private func getMusicResultFromURL(_ url: String) -> MusicResult? {
      let musicResult = songs.first { $0.previewUrl == url }
      return musicResult
  }

  func updatePlayButtonState(isPlaying: Bool) {
    if isPlaying {
      miniPlayerVC.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
      miniPlayerVC.playButton.tintColor = .brandBlack
    } else {
      miniPlayerVC.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
      miniPlayerVC.playButton.tintColor = .brandBlack
    }
  }
}
