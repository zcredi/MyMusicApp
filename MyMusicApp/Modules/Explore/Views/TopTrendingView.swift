//
//  TopTrendingView.swift
//  MyMusicApp
//
//  Created by Владислав on 14.06.2023.
//

import UIKit

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
    
    private lazy var imageArray = ["mus", "mus", "mus"]
    
    private lazy var musicNameLabelArray = ["Do it", "Do it", "Do it"]
    private lazy var authorLabelArray = ["Milian Luu", "Milian Luu", "Milian Luu"]
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
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
        configureScrollView()
        setupViews()
        setConstraints()
        scrollView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width - 48
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(imageArray.count),
                                        height: 200)
        scrollView.isPagingEnabled = true
        
        for index in 0..<imageArray.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * screenWidth,
                                                      y: 0,
                                                      width: screenWidth,
                                                      height: 200))
            imageView.layer.cornerRadius = 8
            imageView.image = UIImage(named: "\(imageArray[index])")
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
            likeButton.setImage(UIImage(named: "like"), for: .normal)
            imageView.addSubview(likeButton)

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
