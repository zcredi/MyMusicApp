//
//  ExploreViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 13.06.2023.
//

import UIKit

class ExploreViewController: UIViewController {
  enum Constants {
    static let exploreLabelTopSpacing: CGFloat = 20.0
    static let exploreLabelLeadingSpacing: CGFloat = 24.0
    static let searchButtonTopSpacing: CGFloat = 40.0
    static let searchButtonTrailingSpacing: CGFloat = 28.0
    static let recentlyLabelTopSpacing: CGFloat = 35.0
    static let recentlyLabelLeadingSpacing: CGFloat = 26.0
    static let recentlyButtonTopSpacing: CGFloat = 47.0
    static let recentlyButtonTrailingSpacing: CGFloat = 24.0
    static let recentlyViewTopSpacing: CGFloat = 16.0
    static let recentlyViewSideSpacing: CGFloat = 24.0
    static let recentlyViewHeightSize: CGFloat = 300.0
    static let topTrendingLabelTopSpacing: CGFloat = 40.0
    static let topTrendingLabelLeadingSpacing: CGFloat = 24.0
  }

  //MARK: - Create UI

  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsVerticalScrollIndicator = true
    scrollView.alwaysBounceVertical = true
    return scrollView
  }()

  private lazy var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var exploreLabel = UILabel(text: "Explore", font: .robotoBold48(), textColor: .neutralWhite)

  private lazy var searchButton = UIButton()

  private lazy var recentlyLabel = UILabel(text: "Recently Music", font: .robotoMedium18(), textColor: .neutralWhite)

  private lazy var recentlyButton: UIButton = {
    let button = UIButton()
    button.setTitle("View all", for: .normal)
    button.setTitleColor(.neutralWhite, for: .normal)
    button.titleLabel?.font = UIFont.robotoBold12()
    button.addTarget(self, action: #selector(recentlyButtonTapped), for: .touchUpInside)
    return button
  }()

  private lazy var topTrendingLabel = UILabel(text: "Top Trending", font: .robotoBold22(), textColor: .neutralWhite)
  private lazy var topikLabel = UILabel(text: "Topic", font: .robotoBold22(), textColor: .neutralWhite)

  private lazy var topikButton: UIButton = {
    let button = UIButton()
    button.setTitle("View all", for: .normal)
    button.setTitleColor(.neutralWhite, for: .normal)
    button.titleLabel?.font = UIFont.robotoBold12()
    button.addTarget(self, action: #selector(topikButtonTapped), for: .touchUpInside)
    return button
  }()

  private lazy var recentlyView = RecentlyView()
  private lazy var topTrendingView = TopTrendingView()
  private lazy var topicView = TopicView()
  private let songPageViewController = SongPageViewController()
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()

  //MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setConstraints()
    setupSearchButton()
    fetchPopularMusic()
    topTrendingView.delegate = self
    miniPlayerVC.delegate = self
//    musicPlayer.delegate = self
    miniPlayerVC.setupCurrentViewController(controller: self)
    miniPlayerVC.setupTargetController(controller: songPageViewController)
  }

  func setupSearchButton() {
    // Настройка внешнего вида кнопки
    searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    searchButton.tintColor = .neutralWhite
    searchButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    searchButton.layer.shadowColor = UIColor.gray.cgColor
    searchButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    searchButton.layer.shadowOpacity = 0.3
    searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
  }

  @objc private func searchPressed() {
    let searchViewController = SearchViewController()
    navigationController?.pushViewController(searchViewController, animated: true)
  }

  @objc
  private func recentlyButtonTapped(_ sender: UIButton) {
    //      let exploreDetailViewController = ExploreDetailViewController(coder: <#NSCoder#>)
    //        exploreDetailViewController.modalPresentationStyle = .fullScreen
    //        present(exploreDetailViewController, animated: true)
  }

  @objc
  private func topikButtonTapped(_ sender: UIButton) {
    let albumTopicViewController = AlbumTopicViewController()
    albumTopicViewController.modalPresentationStyle = .fullScreen
    present(albumTopicViewController, animated: true)
  }

  private func fetchPopularMusic() {
    let networkService = NetworkService()
    networkService.fetchMusicDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topsongs/limit=3/json") { result in
      switch result {
      case .success(let musicResponse):
        DispatchQueue.main.async {
          Music.shared.musicResults = musicResponse.feed.entry
          self.topTrendingView.update(with: Music.shared.musicResults)

        }
      case .failure(let error):
        print("Error fetching music data: \(error)")

      }
    }
}

extension ExploreViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exploreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.exploreLabelTopSpacing),
            exploreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.exploreLabelLeadingSpacing)
        ])
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.searchButtonTopSpacing),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.searchButtonTrailingSpacing)
        ])
        recentlyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyLabel.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: Constants.recentlyLabelTopSpacing),
            recentlyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.recentlyLabelLeadingSpacing)
        ])
        recentlyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: Constants.recentlyButtonTopSpacing),
            recentlyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.recentlyButtonTrailingSpacing)
        ])
        recentlyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyView.topAnchor.constraint(equalTo: recentlyLabel.bottomAnchor, constant: Constants.recentlyViewTopSpacing),
            recentlyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.recentlyViewSideSpacing),
            recentlyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.recentlyViewSideSpacing),
            recentlyView.heightAnchor.constraint(equalToConstant: Constants.recentlyViewHeightSize)
        ])
        topTrendingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTrendingLabel.topAnchor.constraint(equalTo: recentlyView.bottomAnchor, constant: Constants.topTrendingLabelTopSpacing),
            topTrendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.topTrendingLabelLeadingSpacing)
        ])
        topTrendingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTrendingView.topAnchor.constraint(equalTo: topTrendingLabel.bottomAnchor, constant: 20),
            topTrendingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            topTrendingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            topTrendingView.heightAnchor.constraint(equalToConstant: 200),
        ])
        topikLabel.translatesAutoresizingMaskIntoConstraints = false
        topTrendingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topikLabel.topAnchor.constraint(equalTo: topTrendingView.bottomAnchor, constant: 66),
            topikLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
        topikButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topikButton.topAnchor.constraint(equalTo: topTrendingView.bottomAnchor, constant: 66),
            topikButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        topicView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicView.topAnchor.constraint(equalTo: topikLabel.bottomAnchor, constant: 10),
            topicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            topicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            topicView.heightAnchor.constraint(equalToConstant: 160),
            topicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Обработка нажатия на кнопку поиска
        let searchText = searchBar.text ?? ""
        print("Searching for '\(searchText)'")
    }
  }
}

extension ExploreViewController: MiniPlayerViewDelegate {
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

extension ExploreViewController {
    

//  func updateCurrentURL(_ url: String) {
//    guard let musicResult = getMusicResultFromURL(url)
//    else {
//      miniPlayerVC.updateSongTitle("")
//      miniPlayerVC.updateSongImage(nil)
//      return
//    }
//    miniPlayerVC.updateSongTitle(musicResult.name.label)
//    miniPlayerVC.updateSongArtist(musicResult.artist.label)
//    if let imageUrlString = musicResult.images.first?.label,
//       let imageUrl = URL(string: imageUrlString) {
//      URLSession.shared.dataTask(with: imageUrl) { data, response, error in
//        DispatchQueue.main.async {
//          if let imageData = data, let image = UIImage(data: imageData) {
//            self.miniPlayerVC.updateSongImage(image)
//            self.songPageViewController.songInfo = SongInfo(model: musicResult, image: image)
//            self.musicPlayer.musicModel = SongInfo(model: musicResult, image: image)
//          } else {
//            self.miniPlayerVC.updateSongImage(nil)
//          }
//        }
//      }.resume()
//    } else {
//      miniPlayerVC.updateSongImage(nil)
//    }
//  }

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
