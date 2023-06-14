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
    
    private lazy var recentlyView = RecentlyView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setupSearchButton()
    }
    
    func setupSearchButton() {
        // Настройка внешнего вида кнопки
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .neutralWhite
        searchButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        searchButton.layer.shadowColor = UIColor.gray.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchButton.layer.shadowOpacity = 0.3
        searchButton.addTarget(self, action: #selector(showSearchBar(_:)), for: .touchUpInside)
    }
    
    @objc
    private func showSearchBar(_ sender: UIButton) {
        let searchController = UISearchController(searchResultsController: nil) // Создание контроллера поиска
        searchController.searchBar.delegate = self // Установка делегата для обработки событий
        
        present(searchController, animated: true, completion: nil) // Отображение контроллера поиска
    }
    
    @objc
    private func recentlyButtonTapped(_ sender: UIButton) {
        print("recentlyButtonTapped")
    }
    
    private func setupViews() {
        view.backgroundColor = .brandBlack
        view.addSubview(exploreLabel)
        view.addSubview(searchButton)
        view.addSubview(recentlyLabel)
        view.addSubview(recentlyButton)
        view.addSubview(recentlyView)
        view.addSubview(topTrendingLabel)
    }
}

extension ExploreViewController {
    private func setConstraints() {
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exploreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.exploreLabelTopSpacing),
            exploreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.exploreLabelLeadingSpacing)
        ])
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.searchButtonTopSpacing),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.searchButtonTrailingSpacing)
        ])
        recentlyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyLabel.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: Constants.recentlyLabelTopSpacing),
            recentlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.recentlyLabelLeadingSpacing)
        ])
        recentlyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: Constants.recentlyButtonTopSpacing),
            recentlyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.recentlyButtonTrailingSpacing)
        ])
        recentlyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyView.topAnchor.constraint(equalTo: recentlyLabel.bottomAnchor, constant: Constants.recentlyViewTopSpacing),
            recentlyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.recentlyViewSideSpacing),
            recentlyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.recentlyViewSideSpacing),
            recentlyView.heightAnchor.constraint(equalToConstant: Constants.recentlyViewHeightSize)
        ])
        topTrendingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTrendingLabel.topAnchor.constraint(equalTo: recentlyView.bottomAnchor, constant: Constants.topTrendingLabelTopSpacing),
            topTrendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.topTrendingLabelLeadingSpacing)
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
