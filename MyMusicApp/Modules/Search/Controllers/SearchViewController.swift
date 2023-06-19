//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private var searchVC: UISearchController = {
        let searchVC = UISearchController()
        searchVC.searchBar.searchBarStyle = .minimal
        return searchVC
    }()
    
    private let topSearchingLabel = UILabel()
    
    private let categoriesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let element = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let resultsTableView = UITableView()
    
    private let customArray = CustomCellModel.getCustomArray()
    private let categories: [Categories] = [.all, .artist, .album, .song, .playlist]
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchBar()
        configureTopSearchingLabel()
        configureCategoriesCollectionView()
        configureResultsTableView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}

// MARK: - Configure Views
extension SearchViewController {
    
    private func configureVC() {
        view.backgroundColor = .brandBlack
        navigationItem.title = "Search music"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.neutralWhite]
    }
    
    private func configureSearchBar() {
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        
        if let textfield = searchVC.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .neutralBlack
            textfield.placeholder = "Search"
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "",
                                                                 attributes: [NSAttributedString.Key.foregroundColor : UIColor.neutralGray])
            textfield.textColor = .neutralWhite
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .neutralWhite
            }
            
            searchVC.searchBar.tintColor = .brandGreen
        }
    }
    
    private func configureTopSearchingLabel() {
        view.addSubview(topSearchingLabel)
        topSearchingLabel.font = .robotoBold18()
        topSearchingLabel.textColor = .neutralWhite
        topSearchingLabel.text = "Top searching"
        topSearchingLabel.textAlignment = .left
    }
    
    private func  configureCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.backgroundColor = .clear
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.cellId)
    }
    
    private func configureResultsTableView() {
        view.addSubview(resultsTableView)
        resultsTableView.backgroundColor = .clear
        resultsTableView.separatorInset.left = 80
        resultsTableView.separatorColor = .neutralGray
        resultsTableView.indicatorStyle = .white
        
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.register(ResultViewCell.self, forCellReuseIdentifier: ResultViewCell.cellId)
    }
}


// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

    }
 }

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.cellId, for: indexPath) as? CategoriesViewCell else {
            fatalError()
        }
        cell.configureCell(text: categories[indexPath.row].title)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 73)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultViewCell.cellId, for: indexPath) as? ResultViewCell else {
            fatalError()
        }
        
        cell.configureCell(model: customArray[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Setup Constraints
extension SearchViewController {
    
    private func setupConstraints() {
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(73)
        }
        
        topSearchingLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview()
            make.height.equalTo(21)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(topSearchingLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
