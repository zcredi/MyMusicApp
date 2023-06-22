//
//  HomepageViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit
import AVFoundation

class HomepageViewController: UIViewController {

  //MARK: - Outlets
  private let topTitleLabel = UILabel()
  private let searchButton = UIButton(type: .system)
  private let newSongslabel = UILabel()
  private let viewAllButton = UIButton(type: .system)
  private let newSongsView = NewSongsView()
  private let popularAlbumLabel = UILabel()
  private let albumsView = PopularAlbumView()
  private let recentlyMusicLabel = UILabel()
  private let recentlyMusicTableView = RecentlyMusicTableView()

  private let songPageViewController = SongPageViewController()
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()

  override func viewDidLoad() {
    super.viewDidLoad()
    miniPlayerVC.setupCurrentViewController(controller: self)
    miniPlayerVC.setupTargetController(controller: songPageViewController)

    view.backgroundColor = .black
    setupViews()
    setupConstraints()
    fetchPopularMusic()
    fetchPopularAlbum()
    newSongsView.delegate = self
    miniPlayerVC.delegate = self
    musicPlayer.delegate = self
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    miniPlayerVC.removeFromSuperview()
    miniPlayerVC.isUserInteractionEnabled = false
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


  //MARK: - Network requests

  private func fetchPopularMusic() {
    let networkService = NetworkService()
    networkService.fetchMusicDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topsongs/limit=25/json") { result in
      switch result {
      case .success(let musicResponse):
        DispatchQueue.main.async {
          Music.shared.musicResults = musicResponse.feed.entry
          self.newSongsView.update(with: Music.shared.musicResults)
          self.recentlyMusicTableView.update(with: Music.shared.musicResults)
          self.musicPlayer.updateMusicResults(Music.shared.musicResults)
        }
      case .failure(let error):
        print("Error fetching music data: \(error)")

      }
    }
  }

  private func fetchPopularAlbum() {
    let networkService = NetworkService()
    networkService.fetchAlbumDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topalbums/limit=10/json") { result in
      switch result {
      case .success(let albumResponse):
        DispatchQueue.main.async {
          Music.shared.albumResults = albumResponse.feed.entry
          self.albumsView.update(with: Music.shared.albumResults)
        }
      case .failure(let error):
        print("Error fetching popular albums:", error)
      }
    }
  }

  //MARK: - Ui setup

  private func setupViews() {

    configureToptitleLabel()
    configureNewSongslabel()
    configurePopularAlbumLabel()
    configurerecentlyMusicLabel()
    configureSearchButton()
    configureViewAllButton()
    view.addSubview(newSongsView)
    view.addSubview(albumsView)
    view.addSubview(recentlyMusicTableView)
  }

  private func configureToptitleLabel() {
    view.addSubview(topTitleLabel)
    topTitleLabel.text = "Music"
    topTitleLabel.font = UIFont.robotoBold48()
    topTitleLabel.textColor = .white
    topTitleLabel.textAlignment = .left
    topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func configureNewSongslabel() {
    view.addSubview(newSongslabel)
    newSongslabel.text = "New Songs"
    newSongslabel.font = UIFont.robotoRegular18()
    newSongslabel.textColor = .white
    newSongslabel.textAlignment = .left
    newSongslabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func configurePopularAlbumLabel() {
    view.addSubview(popularAlbumLabel)
    popularAlbumLabel.text = "Popular Album"
    popularAlbumLabel.font = UIFont.robotoRegular18()
    popularAlbumLabel.textColor = .white
    popularAlbumLabel.textAlignment = .left
    popularAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func configurerecentlyMusicLabel() {
    view.addSubview(recentlyMusicLabel)
    recentlyMusicLabel.text = "Recently Music"
    recentlyMusicLabel.font = UIFont.robotoRegular18()
    recentlyMusicLabel.textColor = .white
    recentlyMusicLabel.textAlignment = .left
    recentlyMusicLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func configureSearchButton() {
    view.addSubview(searchButton)
    searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    searchButton.tintColor = .white
    searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    searchButton.translatesAutoresizingMaskIntoConstraints = false
  }

  private func configureViewAllButton() {
    view.addSubview(viewAllButton)
    viewAllButton.titleLabel?.font = UIFont.robotoRegular12()
    viewAllButton.tintColor = UIColor.neutralGray
    viewAllButton.setTitle("View all", for: .normal)
    viewAllButton.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
    viewAllButton.translatesAutoresizingMaskIntoConstraints = false
  }

  @objc private func searchPressed() {
    let searchViewController = SearchViewController()
    navigationController?.pushViewController(searchViewController, animated: true)
  }

  @objc func seeAllPressed(sender: UIButton) {
    let allSongsVC = AllSongsViewController()
    let navController = UINavigationController(rootViewController: allSongsVC)
    navController.modalPresentationStyle = .popover
    present(navController, animated: true, completion: nil)
  }

  //MARK: - Constraints
  private func setupConstraints() {
    newSongsView.translatesAutoresizingMaskIntoConstraints = false
    albumsView.translatesAutoresizingMaskIntoConstraints = false
    recentlyMusicTableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),

      searchButton.centerYAnchor.constraint(equalTo: topTitleLabel.centerYAnchor),
      searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

      newSongslabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      newSongslabel.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 38),

      viewAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      viewAllButton.centerYAnchor.constraint(equalTo: newSongslabel.centerYAnchor),

      newSongsView.topAnchor.constraint(equalTo: newSongslabel.bottomAnchor, constant: -2),
      newSongsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      newSongsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      newSongsView.heightAnchor.constraint(equalToConstant: 170),

      popularAlbumLabel.topAnchor.constraint(equalTo: newSongsView.bottomAnchor, constant: 15),
      popularAlbumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

      albumsView.topAnchor.constraint(equalTo: popularAlbumLabel.bottomAnchor, constant: 15),
      albumsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      albumsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      albumsView.heightAnchor.constraint(equalToConstant: 190),

      recentlyMusicLabel.topAnchor.constraint(equalTo: albumsView.bottomAnchor, constant: 15),
      recentlyMusicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

      recentlyMusicTableView.topAnchor.constraint(equalTo: recentlyMusicLabel.bottomAnchor, constant: 20),
      recentlyMusicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      recentlyMusicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      recentlyMusicTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension HomepageViewController: NewSongsViewDelegate {
  //MARK: - NewSongsViewDelegate

  func newSongsView(_ newSongsView: NewSongsView, didSelectSongAt indexPath: IndexPath) {
    let selectedSong = newSongsView.songs[indexPath.row]
    if let audioURL = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
      showMiniPlayer()
      if musicPlayer.isPlayingMusic(from: audioURL) {
        musicPlayer.pauseMusic()
      } else {
        musicPlayer.loadPlayer(from: audioURL, playerType: .musicResults)
      }
    } else {
      print("Error: No audio URL available")
    }
  }
}

extension HomepageViewController: MiniPlayerViewDelegate {
  func forwardButtonTapped() {
    musicPlayer.playNextSong()
  }

  func backwardButtonTapped() {
    musicPlayer.playPreviousSong()
  }

  func playButtonTapped() {
    musicPlayer.isPlayerPerforming() ? musicPlayer.pauseMusic() :  musicPlayer.playMusic()
  }
}

extension HomepageViewController: MusicPlayerDelegate {

  func updateCurrentURL(_ url: String) {
    guard let musicResult = getMusicResultFromURL(url)
    else {
      miniPlayerVC.updateSongTitle("")
      miniPlayerVC.updateSongImage(nil)
      return
    }
    miniPlayerVC.updateSongTitle(musicResult.name.label)
    miniPlayerVC.updateSongArtist(musicResult.artist.label)
    if let imageUrlString = musicResult.images.first?.label,
       let imageUrl = URL(string: imageUrlString) {
      URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        DispatchQueue.main.async {
          if let imageData = data, let image = UIImage(data: imageData) {
            self.miniPlayerVC.updateSongImage(image)
            self.songPageViewController.songInfo = SongInfo(model: musicResult, image: image)
            self.musicPlayer.musicModel = SongInfo(model: musicResult, image: image)
          } else {
            self.miniPlayerVC.updateSongImage(nil)
          }
        }
      }.resume()
    } else {
      miniPlayerVC.updateSongImage(nil)
    }
  }

  private func getMusicResultFromURL(_ url: String) -> Entry? {
    let entry = Music.shared.musicResults.first { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href  == url }
    return entry
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
