//
//  PopularAlbomView.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 13.06.2023.
//

import UIKit

class PopularAlbumView: UIView {
  
  var collectionView: UICollectionView!
  var selectedAlbumName: String?
  private let miniPlayerVC = MiniPlayerVC()
  private let musicPlayer = MusicPlayer.instance
  var songs: [AlbumEntry] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
    addSubview(collectionView)
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func setupConstraints() {
    collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  func update(with musicResults: [AlbumEntry]) {
    songs = musicResults
  }
  
  private func searchMusic() {
          if let albumName = selectedAlbumName {
              let networkService = NetworkService()
              networkService.fetchMusic(keyword: albumName) { result in
                  switch result {
                  case .success(let albums):
                      DispatchQueue.main.async {
                          let filteredAlbums = albums.filter { $0.collectionName == albumName }
                          self.showSearchResultsAlert(with: filteredAlbums)
                      }
                  case .failure(let error):
                      print("Ошибка загрузки новых релизов:", error)
                  }
              }
          }
      }

  private func showSearchResultsAlert(with albumResults: [MusicResult]) {
      guard let scene = UIApplication.shared.connectedScenes.first,
            let windowScene = scene as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController else {
          return
      }

      let albumDetailViewController = AlbumDetailViewController()
      albumDetailViewController.update(with: albumResults)
      albumDetailViewController.modalPresentationStyle = .fullScreen

      rootViewController.present(albumDetailViewController, animated: true, completion: nil)
  }

  private func didSelectAlbum(at index: Int) {
          let selectedAlbum = songs[index]
          selectedAlbumName = selectedAlbum.name.label
          searchMusic()
      }
  }


// MARK: - Extensions
extension PopularAlbumView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return songs.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.identifier, for: indexPath) as? AlbumCell else {
      return UICollectionViewCell()
    }
    let selectedSong = songs[indexPath.row]
    cell.configureCell(with: selectedSong)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth - 16
    let itemHeight: CGFloat = 190
    return CGSize(width: itemWidth, height: itemHeight)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    miniPlayerVC.closeMiniPlayer()
    musicPlayer.stopMusic()
    let selectedAlbum = songs[indexPath.row]
        let albumName = selectedAlbum.name.label
        selectedAlbumName = albumName
        searchMusic()
        didSelectAlbum(at: indexPath.row)
    }
}
