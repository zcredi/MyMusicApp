//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesLabel = UILabel()
    
    private let categoriesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let element = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let favoritesTableView = UITableView()
    
    private let customArray = CustomCellModel.getCustomArray()
    private let categories: [Categories] = [.all, .artist, .album, .song, .playlist]
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureFavoriteLabel()
        configureCategoriesCollectionView()
        configureResultsTableView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}

// MARK: - Configure Views
extension FavoritesViewController {
    
    private func configureVC() {
        view.backgroundColor = .brandBlack
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.neutralWhite]
    }
    
    private func configureFavoriteLabel() {
        view.addSubview(favoritesLabel)
        favoritesLabel.font = .robotoBold18()
        favoritesLabel.textColor = .neutralWhite
        favoritesLabel.text = "Favorites"
        favoritesLabel.textAlignment = .left
    }
    
    private func  configureCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.backgroundColor = .clear
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: CategoriesViewCell.cellId)
    }
    
    private func configureResultsTableView() {
        view.addSubview(favoritesTableView)
        favoritesTableView.backgroundColor = .clear
        favoritesTableView.separatorInset.left = 80
        favoritesTableView.separatorColor = .neutralGray
        favoritesTableView.indicatorStyle = .white
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(FavoritesViewCell.self, forCellReuseIdentifier: FavoritesViewCell.cellId)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    
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
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 73)
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesViewCell.cellId, for: indexPath) as? FavoritesViewCell else {
            fatalError()
        }
        
        cell.configureCell(model: customArray[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Setup Constraints
extension FavoritesViewController {
    
    private func setupConstraints() {
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(73)
        }
        
        favoritesLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview()
            make.height.equalTo(21)
        }
        
        favoritesTableView.snp.makeConstraints { make in
            make.top.equalTo(favoritesLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - CellDelegate
extension FavoritesViewController: CellDelegate {
    
    func buttonPressed(_ cell: FavoritesViewCell) {
        guard let indexPath = favoritesTableView.indexPath(for: cell) else { return }
        let alertController = UIAlertController(title: "Delete frome Favorites?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.favoritesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
       
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}
