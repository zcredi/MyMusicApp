//
//  TopTrendingView.swift
//  MyMusicApp
//
//  Created by Владислав on 14.06.2023.
//

import UIKit
import Kingfisher

protocol TopTrendingViewDelegate: AnyObject {
  func topTrendingView(_ topTrendingView: TopTrendingView, didSelectSongAt indexPath: IndexPath)
  func setEntryModel(model: Entry)
  func isCurrentModelFavorite(model: Entry) -> Bool
  func likeButtonDidTap(model: Entry)
}

class TopTrendingView: UIView, UIScrollViewDelegate {
  enum Constants {
    static let scrollViewSideSpasing: CGFloat = 0.0
    static let musicImageLeadingSpacing: CGFloat = 0.0
    static let musicImageHeightSize: CGFloat = 200.0
    static let musicNameLabelTopSpacing: CGFloat = 145.0
    static let musicNameLabelLeadingSpacing: CGFloat = 15.0
    static let authorLabelTopSpacing: CGFloat = 4.0
    static let authorLabelLeadingSpacing: CGFloat = 14.0
    static let likeButtonBottomSpacing: CGFloat = 18.0
    static let likeButtonTrailingSpacing: CGFloat = 18.0
  }

  //MARK: - Create UI
  weak var delegate: TopTrendingViewDelegate?

  var songs: [Entry] = []
  private var imageArray: [UIImageView] = []
  private var musicNameLabelArray: [String] = []
  private var authorLabelArray: [String] = []
  func update(with musicResults: [Entry]) {
    songs = musicResults
    populateVariablesFromSongs()
    configureScrollView()
  }

  private func populateVariablesFromSongs() {
    imageArray = songs.map { song in
      let imageView = UIImageView()
      if let imageUrlString = song.images.first?.label,
         let imageUrl = URL(string: imageUrlString) {
        imageView.kf.setImage(with: imageUrl)
      }
      return imageView
    }
    musicNameLabelArray = songs.map { $0.name.label }
    authorLabelArray = songs.map { $0.artist.label }
  }

  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "heart.fill"), for: .normal)
    return button
  }()

  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.alwaysBounceHorizontal = true
      
    return scrollView
  }()

  private lazy var musicPageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.numberOfPages = 3
    pageControl.currentPage = 0
    if #available(iOS 16.0, *) {
      pageControl.preferredCurrentPageIndicatorImage = UIImage(named: "activ")
    } else {
      print("Error MusicPageControl")
    }
    pageControl.preferredIndicatorImage = UIImage(named: "unactiv")
    return pageControl
  }()

  //MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setConstraints()
    scrollView.delegate = self
    configureScrollView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureScrollView() {
      guard let delegate = delegate else { return }
      
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width - 48
    scrollView.contentSize = CGSize(width: screenWidth * CGFloat(imageArray.count),
                                    height: Constants.musicImageHeightSize)
    scrollView.isPagingEnabled = true

    for index in 0..<imageArray.count {
      let imageView = imageArray[index]
      imageView.frame = CGRect(x: CGFloat(index) * screenWidth,
                               y: 0,
                               width: screenWidth,
                               height: scrollView.bounds.height)
      imageView.layer.cornerRadius = 8
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      scrollView.addSubview(imageView)

      let musicNameLabel = UILabel(text: musicNameLabelArray[index], font: .robotoBold16(), textColor: .neutralWhite)
      scrollView.addSubview(musicNameLabel)

      musicNameLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        musicNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.musicNameLabelTopSpacing),
        musicNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenWidth * CGFloat(index) + Constants.musicNameLabelLeadingSpacing)
      ])
      let authorLabel = UILabel(text: authorLabelArray[index], font: .robotoRegular14(), textColor: .neutralWhite)
      scrollView.addSubview(authorLabel)

      authorLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        authorLabel.topAnchor.constraint(equalTo: musicNameLabel.bottomAnchor, constant: Constants.authorLabelTopSpacing),
        authorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenWidth * CGFloat(index) + Constants.authorLabelLeadingSpacing)
      ])

      let likeButton = UIButton(type: .system)
        if delegate.isCurrentModelFavorite(model: songs[index]) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
      likeButton.addTarget(self, action: #selector(changeLikeStatus), for: .touchUpInside)
      likeButton.tintColor = .neutralWhite
      
      scrollView.addSubview(likeButton)
      likeButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        likeButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -Constants.likeButtonBottomSpacing),
        likeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -Constants.likeButtonTrailingSpacing)
      ])
    }
  }

  private func setupViews() {
    addSubview(scrollView)
    addSubview(musicPageControl)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    musicPageControl.currentPage = Int(pageNumber)
  }
    
    @objc private func changeLikeStatus(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(systemName: "heart") {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        delegate?.setEntryModel(model: songs[musicPageControl.currentPage])
    }
}

extension TopTrendingView {
  private func setConstraints() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    musicPageControl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      musicPageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 23),
      musicPageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
}
