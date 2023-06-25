//
//  ExploreDetailViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 19.06.2023.
//

import UIKit

class ExploreDetailViewController: UIViewController {
  enum Constants {
    static let playButtonTopSpacing: CGFloat = 160.0
    static let nameAlbumTopSpacing: CGFloat = 130.0
    static let nameAlbumLeadingSpacing: CGFloat = 24.0
    static let descriptionAlbumdTopSpacing: CGFloat = 10.0
    static let descriptionAlbumdLeadingSpacing: CGFloat = 24.0
    static let lineViewTopSpacing: CGFloat = 36.0
    static let lineViewSideSpacing: CGFloat = 23.0
    static let lineViewHeightSpacing: CGFloat = 1.0
  }
  
  //MARK: - Create UI
  
  private lazy var playImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "playwhite"))
    return imageView
  }()
  
  private lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "ellipse"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var descriptionAlbumd = UILabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it", font: .robotoRegular14(), textColor: .neutralWhite)
  
  private lazy var lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .neutralWhite
    return view
  }()
  
  
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()
  let genreID: Int
  let genre: String
  let genreImageName: String
  let nameAlbum: UILabel
  let backView: UIImageView
  private let exploreView: ExploreDetails
  
  init(genre: String, genreID: Int, genreImageName: String) {
    self.genreID = genreID
    self.genre = genre
    self.genreImageName = genreImageName
    self.nameAlbum = UILabel(text: genre, font: .robotoBold36(), textColor: .neutralWhite)
    self.backView = UIImageView(image: UIImage(named: genreImageName))
    self.backView.contentMode = .scaleAspectFill
    self.exploreView = ExploreDetails(genreID: genreID)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  private lazy var exploreDetailsView = ExploreDetails(genreID: genreID)
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setConstraints()
    miniPlayerVC.delegate = self
    musicPlayer.delegate = self
    exploreView.delegate = self
  }
  
  @objc
  private func playerButtonTapped() {
    print("Play")
    showMiniPlayer()
  }
  
  private func setupViews() {
    view.addSubview(backView)
    view.addSubview(playButton)
    playButton.addSubview(playImage)
    backView.addSubview(nameAlbum)
    backView.addSubview(descriptionAlbumd)
    descriptionAlbumd.numberOfLines = 5
    backView.addSubview(lineView)
    view.addSubview(exploreDetailsView)
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
}

extension ExploreDetailViewController {
  private func setConstraints() {
    backView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backView.topAnchor.constraint(equalTo: view.topAnchor),
      backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    playButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.playButtonTopSpacing),
      //            playButton.heightAnchor.constraint(equalToConstant: 73),
      playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    playImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playImage.topAnchor.constraint(equalTo: playButton.topAnchor, constant: 20),
      playImage.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 28),
      playImage.heightAnchor.constraint(equalToConstant: 34)
    ])
    nameAlbum.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameAlbum.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: Constants.nameAlbumTopSpacing),
      nameAlbum.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.nameAlbumLeadingSpacing)
    ])
    descriptionAlbumd.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionAlbumd.topAnchor.constraint(equalTo: nameAlbum.bottomAnchor, constant: Constants.descriptionAlbumdTopSpacing),
      descriptionAlbumd.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.descriptionAlbumdLeadingSpacing),
      descriptionAlbumd.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -Constants.descriptionAlbumdLeadingSpacing)
    ])
    lineView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      lineView.topAnchor.constraint(equalTo: descriptionAlbumd.bottomAnchor, constant: Constants.lineViewTopSpacing),
      lineView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.lineViewSideSpacing),
      lineView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -Constants.lineViewSideSpacing),
      lineView.heightAnchor.constraint(equalToConstant: Constants.lineViewHeightSpacing)
    ])
    exploreDetailsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      exploreDetailsView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
      exploreDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      exploreDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
      exploreDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
    ])
  }
}

extension ExploreDetailViewController: MiniPlayerViewDelegate {
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

extension ExploreDetailViewController: ExploreDetailsDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("tap tap")
    let selectedSong = exploreView.songs[indexPath.row]
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

extension ExploreDetailViewController: MusicPlayerDelegate {
  
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
