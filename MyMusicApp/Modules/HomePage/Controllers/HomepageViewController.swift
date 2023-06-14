//
//  HomepageViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit

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

  var musicResults: [MusicResult] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupViews()
    setupConstraints()
    fetchPopularMusic()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

  func updateUI(with musicResults: [MusicResult]) {
    newSongsView.update(with: musicResults)
  }

  //MARK: - Network requests

  private func fetchPopularMusic() {
    let networkService = NetworkService()
    networkService.fetchMusic(keyword: "eminem") { result in
      switch result {
      case .success(let musicResults):
        self.musicResults = musicResults
        DispatchQueue.main.async {
          self.newSongsView.update(with: musicResults)
          self.albumsView.update(with: musicResults)
          self.recentlyMusicTableView.update(with: musicResults)
        }

      case .failure(let error):
        // Обработка ошибки загрузки
        print("Ошибка загрузки новых релизов:", error)
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

      newSongsView.topAnchor.constraint(equalTo: newSongslabel.bottomAnchor, constant: 9),
      newSongsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      newSongsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      newSongsView.heightAnchor.constraint(equalToConstant: 220),

      popularAlbumLabel.topAnchor.constraint(equalTo: newSongsView.bottomAnchor, constant: 15),
      popularAlbumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

      albumsView.topAnchor.constraint(equalTo: popularAlbumLabel.bottomAnchor, constant: 15),
      albumsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      albumsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      albumsView.heightAnchor.constraint(equalToConstant: 100),

      recentlyMusicLabel.topAnchor.constraint(equalTo: albumsView.bottomAnchor, constant: 15),
      recentlyMusicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

      recentlyMusicTableView.topAnchor.constraint(equalTo: recentlyMusicLabel.bottomAnchor, constant: 20),
      recentlyMusicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      recentlyMusicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      recentlyMusicTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
