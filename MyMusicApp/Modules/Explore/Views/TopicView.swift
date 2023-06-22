//
//  TopicView.swift
//  MyMusicApp
//
//  Created by Владислав on 14.06.2023.
//

import UIKit

class TopicView: UIView {
  enum Constants {
    static let idTopicCell: String = "idTopicCell"
    static let collectionViewSizeSpacing: CGFloat = 0.0
    static let collectionViewLeadingSpacing: CGFloat = 0.0
    static let collectionViewTrailingSpacing: CGFloat = 0.0
  }
  var songs: [Entry] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  private var currentGenre: Int = 6
  private var genreNames: [Int: String] = [6: "Country",
                                           7: "Electronic",
                                           11: "Jazz",
                                           12: "Latin",
                                           13: "New Age",
                                           14: "Pop",
                                           15: "R&B/Soul",
                                           16: "Soundtrack",
                                           17: "Dance",
                                           18: "Hip Hop/Rap",
                                           21: "Hard Rock"]

  //MARK: - Create UI

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()


  //MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idTopicCell)
    setupViews()
    setConstraints()
    setDelegates()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setDelegates() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupViews() {
    addSubview(collectionView)
  }

  func update(with musicResults: [Entry]) {
    songs = musicResults
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }


  private func fetchMusicForAllGenres(currentIndex: Int) {
    guard let genre = genreNames[currentIndex] else {
      return
    }

    print("Selected genre: \(genre)")
    currentGenre = currentIndex
    fetchPopularMusic(forGenre: currentIndex)
  }

  private func fetchPopularMusic(forGenre genre: Int) {
      let urlString = "https://itunes.apple.com/us/rss/topsongs/genre=\(genre)/limit=25/json"
      let networkService = NetworkService()
      networkService.fetchMusicDataFromAPI(urlString: urlString) { result in
          switch result {
          case .success(let musicResponse):
              DispatchQueue.main.async {
                  Music.shared.musicResults = musicResponse.feed.entry
                  self.update(with: Music.shared.musicResults)
                  print(self.genreNames)
                  print(genre)
              }
          case .failure(let error):
              print("Error fetching music data: \(error)")
          }
      }
  }
  }

extension TopicView {
  private func setConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.collectionViewSizeSpacing),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.collectionViewSizeSpacing),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.collectionViewTrailingSpacing),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.collectionViewLeadingSpacing)
    ])
  }
}

extension TopicView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return genreNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.idTopicCell, for: indexPath) as? TopicCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let genreIndex = indexPath.item
    let genre = Array(genreNames.values)[genreIndex]
    cell.genreMusicLabel.text = genre
    print(genre)
    return cell
  }
}

extension TopicView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 3.2
    let height = collectionView.frame.height / 2
    return CGSize(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

extension TopicView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genreIndex = indexPath.item
      
        fetchMusicForAllGenres(currentIndex: genreIndex)
    }
}
