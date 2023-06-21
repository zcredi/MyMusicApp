//
//  TopicCollectionView.swift
//  MyMusicApp
//
//  Created by Владислав on 20.06.2023.
//

import UIKit

class AlbumCollectionView: UIView {
    enum Constants {
        static let idAlbumTopicCell: String = "idAlbumTopicCell"
        static let collectionViewSizeSpacing: CGFloat = 0.0
        static let collectionViewLeadingSpacing: CGFloat = 0.0
        static let collectionViewTrailingSpacing: CGFloat = 0.0
    }
    
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
        
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idAlbumTopicCell)
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
    
}

extension AlbumCollectionView {
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

extension AlbumCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.idAlbumTopicCell, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

extension AlbumCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3.2
            let height = collectionView.frame.height / 2
            return CGSize(width: width, height: height)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         0
    }
}
