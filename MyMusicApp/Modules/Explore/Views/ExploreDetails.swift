//
//  ExploreDetails.swift
//  MyMusicApp
//
//  Created by Владислав on 15.06.2023.
//

import UIKit

protocol ExploreDetailsDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class ExploreDetails: UIView {

  enum Constants {
    static let idExploreDetailsCell: String = "idExploreDetailsCell"
    static let collectionViewSizeSpacing: CGFloat = 4.0
    static let collectionViewLeadingSpacing: CGFloat = 12.0
    static let collectionViewTrailingSpacing: CGFloat = 16.0
  }

  weak var delegate: ExploreDetailsDelegate?
  var genreID: Int
  var songs: [Entry] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()

  func update(with musicResults: [Entry]) {
    songs = musicResults
  }
  //MARK: - Create UI

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()


  //MARK: - Lifecycle

  init(genreID: Int) {
    self.genreID = genreID
    super.init(frame: .zero)

    collectionView.register(ExploreDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idExploreDetailsCell)
    setupViews()
    setConstraints()
    setDelegates()
    fetchPopularMusic(genre: genreID)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setDelegates() {
    collectionView.delegate = self
    collectionView.dataSource = self
    miniPlayerVC.delegate = self
    musicPlayer.delegate = self
  }

  private func setupViews() {
    backgroundColor = .clear
    addSubview(collectionView)
  }

  private func fetchPopularMusic(genre: Int) {
    let urlString = "https://itunes.apple.com/us/rss/topsongs/genre=\(genre)/limit=25/json"
    let networkService = NetworkService()
    networkService.fetchMusicDataFromAPI(urlString: urlString) { result in
      switch result {
      case .success(let musicResponse):
        DispatchQueue.main.async {
          Music.shared.musicResults = musicResponse.feed.entry
          self.update(with: Music.shared.musicResults)
        }
      case .failure(let error):
        print("Error fetching music data: \(error)")
      }
    }
  }
}

extension ExploreDetails {
    private func setConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.collectionViewSizeSpacing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.collectionViewSizeSpacing),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.collectionViewTrailingSpacing),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.collectionViewLeadingSpacing)
        ])
    }

  func showMiniPlayer() {
      guard let window = UIApplication.shared.keyWindow else {
          return
      }

      miniPlayerVC.translatesAutoresizingMaskIntoConstraints = false
      window.addSubview(miniPlayerVC)
      NSLayoutConstraint.activate([
          miniPlayerVC.leadingAnchor.constraint(equalTo: window.leadingAnchor),
          miniPlayerVC.trailingAnchor.constraint(equalTo: window.trailingAnchor),
          miniPlayerVC.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -80),
          miniPlayerVC.heightAnchor.constraint(equalToConstant: 70)
      ])
  }
}

extension ExploreDetails: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.idExploreDetailsCell, for: indexPath) as? ExploreDetailCollectionViewCell else { return UICollectionViewCell() }

          let musicResult = songs[indexPath.item]
        let songNumber = indexPath.row+1
        cell.configureCell(with: musicResult, songNumber: songNumber)
        return cell
    }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedSong = songs[indexPath.row]
        if let audioURL = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
          updateCurrentURL(audioURL)
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

extension ExploreDetails: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height / 5.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
    }
}

extension ExploreDetails: MusicPlayerDelegate {

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

extension ExploreDetails: MiniPlayerViewDelegate {
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
