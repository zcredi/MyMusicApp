//
//  ExploreDetails.swift
//  MyMusicApp
//
//  Created by Владислав on 15.06.2023.
//

import UIKit

class ExploreDetails: UIView {
    enum Constants {
        static let idExploreDetailsCell: String = "idExploreDetailsCell"
        static let collectionViewSizeSpacing: CGFloat = 4.0
        static let collectionViewLeadingSpacing: CGFloat = 12.0
        static let collectionViewTrailingSpacing: CGFloat = 16.0
    }

  var genreID: Int
  var songs: [Entry] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

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
      print(genreID)
  }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
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
