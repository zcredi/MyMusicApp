//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let label = UILabel()
    private let tableView = UITableView()
    
    private let customArray = CustomCellModel.getCustomArray()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLabel()
        configureTableView()
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
    
    private func configureLabel() {
        view.addSubview(label)
        label.font = .robotoBold18()
        label.textColor = .neutralWhite
        label.text = "Favorites"
        label.textAlignment = .left
    }
        
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorInset.left = 80
        tableView.separatorColor = .neutralGray
        tableView.indicatorStyle = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesViewCell.self, forCellReuseIdentifier: FavoritesViewCell.cellId)
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
                
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview()
            make.height.equalTo(21)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - CellDelegate
extension FavoritesViewController: CellDelegate {
    
    func buttonPressed(_ cell: FavoritesViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alertController = UIAlertController(title: "Delete frome Favorites?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
       
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}
