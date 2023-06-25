//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    var songViewController: SongViewControllerProtocol?
    
    private let label = UILabel()
    private let tableView = UITableView()
    
    private var customArray = CustomCellModel.getCustomArray()

    private var favoriteArray: Results<FavoritesModel>?
    
    var exploreViewController: ExploreViewController?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLabel()
        configureTableView()
        setupConstraints()
        songViewController?.favoriteVC = self
    }
 
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        loadInRealm()
        setFavoritesArray(favoriteArray!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadInRealm() {
        favoriteArray = RealmManager.shared.getResultFavoritesModel()
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func appendFavoriteSong(_ model: Entry) {
        let urlString = model.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href
//        customArray.append(CustomCellModel(avatarImageString: model.images.first?.label ?? "",
//                                           title: model.name.label,
//                                           subtitle: model.artist.label,
//                                           album: "",
//                                           url: urlString ?? ""))
        let favoriteSong = FavoritesModel()
        favoriteSong.songName = model.name.label
        favoriteSong.songAuthor = model.artist.label
        favoriteSong.songImage = model.images[0].label
        favoriteSong.favoriteStatus = true
        isContaints(model: favoriteSong)
        RealmManager.shared.saveFavoritesModel(favoriteSong)
        loadInRealm()
        setFavoritesArray(favoriteArray!)
        tableView.reloadData()
    }
    
    func removeSongFromFavorites(selectedSong: Entry) {
        guard let foundedURLString = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href else { return }

//        guard let index = customArray.firstIndex(where: { $0.url == foundedURLString }) else { return }
        let favoriteSong = FavoritesModel()
        favoriteSong.songName = selectedSong.name.label
        favoriteSong.songAuthor = selectedSong.artist.label
        favoriteSong.songImage = selectedSong.images[0].label
        favoriteSong.favoriteStatus = false
        isContaints(model: favoriteSong)

        tableView.reloadData()
    }

    func isCurrentSongFavorite(selectedSong: Entry) -> Bool {
//        guard let foundedURLString = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href, let favoriteArray = favoriteArray else { return false }
        guard let favoriteArray = favoriteArray else { return false }
        let selectedSongName = selectedSong.name.label
    
        return favoriteArray.contains(where: { favoritesModel in
            favoritesModel.songName == selectedSongName
        })
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
        label.font = .robotoBold48()
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
    
     func setFavoritesArray(_ array: Results<FavoritesModel>) {
        favoriteArray = array
//        var newArray = [FavoritesModel]()
//        array.forEach { favorites in
//            var test = [FavoritesModel]()
//            let favoritesTest = FavoritesModel()
//            favoritesTest.songName = favorites.songName
//            favoritesTest.songAuthor = favorites.songAuthor
//            favoritesTest.songImage = favorites.songImage
//            newArray.append(favoritesTest)
//        }
//        tableView.reloadData()
    }
}

extension FavoritesViewController {
    func isContaints(model: FavoritesModel) {
        favoriteArray?.forEach({ favorite in
            if model.songName == favorite.songName {
                RealmManager.shared.deleteFavoritesModel(model)
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesViewCell.cellId, for: indexPath) as? FavoritesViewCell else {
            fatalError()
        }
        let favoriteModel = favoriteArray?[indexPath.row]
        cell.configureCell(model: favoriteModel!)
        cell.delegate = self
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
        let alertController = UIAlertController(title: "Delete from Favorites?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            guard let model = self.favoriteArray?[indexPath.row] else { return }
           
            self.isContaints(model: model)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.songViewController?.reloadLikeButton()
            self.exploreViewController?.reloadTopTrending()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }

}
