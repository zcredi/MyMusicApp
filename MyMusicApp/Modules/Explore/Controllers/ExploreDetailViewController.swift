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
    
    private lazy var backView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var playImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "playWhite"))
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ellipse"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var nameAlbum = UILabel(text: "Rap Soul", font: .robotoBold36(), textColor: .neutralWhite)
    private lazy var descriptionAlbumd = UILabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it", font: .robotoRegular14(), textColor: .neutralWhite)
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        return view
    }()


  private let audioPlayer = MusicPlayer.instance
    let genreID: Int
    let genre: String
      init(genre: String, genreID: Int) {
          self.genreID = genreID
          self.genre = genre
          self.nameAlbum = UILabel(text: genre, font: .robotoBold36(), textColor: .neutralWhite)
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
    }
    
    @objc
    private func playerButtonTapped() {
        print("Play")
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
