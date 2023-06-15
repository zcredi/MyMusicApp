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

  var musicResults: [Entry] = []
  var albumResults: [Album1] = []
  let musicPlayer = MusicPlayer()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupViews()
    setupConstraints()
    fetchPopularMusic()
    //    fetchPopularAlbum()
    newSongsView.delegate = self
    recentlyMusicTableView.delegate = self
  }
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    //MARK: - Network requests

    private func fetchPopularMusic() {
      fetchMusicDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topsongs/limit=25/json") { result in
        switch result {
        case .success(let musicResponse):
          DispatchQueue.main.async {
            self.musicResults = musicResponse.feed.entry
            self.newSongsView.update(with: self.musicResults)
            self.recentlyMusicTableView.update(with: self.musicResults)
          }
        case .failure(let error):
          print("Error fetching music data: \(error)")

        }
      }
    }

    private func fetchPopularAlbum() {
      fetchMusicDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topalbums/limit=10/json") { result in
        switch result {
        case .success(let musicResponse):
          DispatchQueue.main.async {
            self.musicResults = musicResponse.feed.entry
            self.albumsView.update(with: self.musicResults)
          }
        case .failure(let error):
          print("Ошибка загрузки новых альбомов:", error)
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
      searchButton.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
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

    @objc func seeAllPressed(sender: UIButton) {

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
  func newSongsView(_ newSongsView: NewSongsView, didSelectSongAt indexPath: IndexPath) {
    let selectedSong = newSongsView.songs[indexPath.row]
    if let audioURL = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
      if musicPlayer.isPlayingMusic(from: audioURL) {
        musicPlayer.stopMusic()
      } else {
        musicPlayer.playMusic(from: audioURL)
      }
    } else {
      print("Error: No audio URL available")
    }
  }
}
  extension HomepageViewController: UITableViewDelegate {
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if tableView == recentlyMusicTableView {
              let selectedSong = recentlyMusicTableView.songs[indexPath.row]
              if let audioURL = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
                  if musicPlayer.isPlayingMusic(from: audioURL) {
                      musicPlayer.stopMusic()
                  } else {
                      musicPlayer.playMusic(from: audioURL)
                  }
              } else {
                  print("Error: No audio URL available")
              }
          }
      }
  }
