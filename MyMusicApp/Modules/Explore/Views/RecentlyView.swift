//
//  RecentlyView.swift
//  MyMusicApp
//
//  Created by Владислав on 13.06.2023.
//

import UIKit
import RealmSwift

class RecentlyView: UIView {
    enum Constants {
        static let idRecentlyCell: String = "idRecentlyCell"
        static let collectionViewSizeSpacing: CGFloat = 4.0
        static let collectionViewLeadingSpacing: CGFloat = 5.0
        static let collectionViewTrailingSpacing: CGFloat = 8.0
    }
    
    private var recentlyArray = [RecentlyModel]()
    
    //MARK: - Create UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(RecentlyCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idRecentlyCell)
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
        backgroundColor = .collectionColor
        layer.cornerRadius = 8
        addSubview(collectionView)
    }
    
    public func setRecentlyArray(_ array: Results<RecentlyModel>) {
        var newArray = [RecentlyModel]()
        array.forEach { recently in
            var test = [RecentlyModel]()
            let recentlyTest = RecentlyModel()
            recentlyTest.songName = recently.songName
            recentlyTest.songAuthor = recently.songAuthor
            recentlyTest.songImage = recently.songImage
            newArray.append(recentlyTest)
        }
        recentlyArray = newArray.reversed()
        collectionView.reloadData()
    }
    
}

extension RecentlyView {
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

extension RecentlyView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentlyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.idRecentlyCell, for: indexPath) as? RecentlyCollectionViewCell else { return UICollectionViewCell() }
        
        let songNumber = indexPath.row + 1
        let recentlyModel = recentlyArray[indexPath.row]
        cell.configure(model: recentlyModel, songNumber: songNumber)
        
        return cell
    }
    
    
}

extension RecentlyView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height / 5.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}
