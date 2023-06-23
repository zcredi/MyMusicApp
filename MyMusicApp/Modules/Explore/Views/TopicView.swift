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

  private var genreNames: [Int: (name: String, imageName: String)] = [
      6: ("Country", "countryImage"),
      7: ("Electronic", "electronicImage"),
      11: ("Jazz", "jazzImage"),
      12: ("Latin", "latinImage"),
      13: ("New Age", "newAgeImage"),
      14: ("Pop", "popImage"),
      15: ("R&B/Soul", "rnbSoulImage"),
      16: ("Soundtrack", "soundtrackImage"),
      17: ("Dance", "danceImage"),
      18: ("Hip Hop/Rap", "hipHopRapImage"),
      21: ("Hard Rock", "hardRockImage")
  ]

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

//
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
    cell.genreMusicLabel.text = genre.name
    cell.genreMusicImage.image = UIImage(named: genre.imageName)
    return cell
  }
}

extension TopicView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width / 3.2
    let height = collectionView.bounds.height / 2.0
    return CGSize(width: width, height: height)
  }
}

extension TopicView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let genreIndex = indexPath.item
    let genreID = Array(genreNames.keys)[genreIndex]
    let selectedGenre = genreNames[genreID]
    
    if let genreImageName = selectedGenre?.imageName {
      let exploreDetailViewController = ExploreDetailViewController(genre: selectedGenre?.name ?? "", genreID: genreID, genreImageName: genreImageName)
      
      if let viewController = self.getViewController() {
        viewController.navigationController?.pushViewController(exploreDetailViewController, animated: true)
      }
    }
  }
    private func getViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
