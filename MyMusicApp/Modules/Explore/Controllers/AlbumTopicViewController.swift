//
//  ExploreTopicViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 20.06.2023.
//

import UIKit

class AlbumTopicViewController: UIViewController {
    
    //MARK: - Create UI
    
    private lazy var topicLabel = UILabel(text: "Hip Hop", font: .robotoBold18(), textColor: .neutralWhite)
    
    private lazy var albumCollectionView = AlbumCollectionView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .brandBlack
        view.addSubview(topicLabel)
        view.addSubview(albumCollectionView)
    }
}

extension AlbumTopicViewController {
    private func setConstraints() {
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),
            topicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        albumCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumCollectionView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 32),
            albumCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            albumCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
}
