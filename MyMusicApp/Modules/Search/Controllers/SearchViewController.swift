//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

  private let songPageViewController = SongPageViewController()
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()

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

    private var customArray = CustomCellModel.getCustomArray()
    private var filteredArray: [CustomCellModel] = []
    private let categories: [Categories] = [.all, .artist, .album, .song, .playlist]
    private var selectedCategory: Categories = .all
  private var isSearching: Bool = false



    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchBar()
        configureTopSearchingLabel()
        configureCategoriesCollectionView()
        configureResultsTableView()
        setupConstraints()

        filteredArray = customArray
        selectDefaultCategory()

      miniPlayerVC.setupCurrentViewController(controller: self)
      miniPlayerVC.setupTargetController(controller: songPageViewController)
      miniPlayerVC.delegate = self
      musicPlayer.delegate = self
    }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    miniPlayerVC.removeFromSuperview()
    miniPlayerVC.isUserInteractionEnabled = false
  }
  
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }

  func showMiniPlayer() {
      miniPlayerVC.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(miniPlayerVC)
      NSLayoutConstraint.activate([
          miniPlayerVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          miniPlayerVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          miniPlayerVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
          miniPlayerVC.heightAnchor.constraint(equalToConstant: 70)
      ])
  }

    // MARK: - Configure Views
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

    // MARK: - Setup Constraints
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

    // MARK: - Helper Methods
    private func selectDefaultCategory() {
        let indexPath = IndexPath(item: 0, section: 0)
        categoriesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        collectionView(categoriesCollectionView, didSelectItemAt: indexPath)
    }

  private func performSearch(with keyword: String) {
      switch selectedCategory {
      case .all:
          filteredArray = customArray.filter { $0.title.contains(keyword) || $0.subtitle.contains(keyword) || $0.album.contains(keyword) }
      case .artist:
        filteredArray = customArray.compactMap { $0.subtitle.contains(keyword) ? CustomCellModel(avatarImageString: $0.avatarImageString, title: $0.subtitle, subtitle: "", album: "", url: $0.url) : nil }
          filteredArray = removeDuplicateArtists(from: filteredArray)
      case .album:
          filteredArray = customArray.filter { $0.album.contains(keyword) }
      case .song:
          filteredArray = customArray.filter { $0.title.contains(keyword) }
      case .playlist:
          filteredArray = customArray.filter { $0.subtitle.contains(keyword) }
      }

      resultsTableView.reloadData()
  }


    private func removeDuplicateArtists(from results: [CustomCellModel]) -> [CustomCellModel] {
        var uniqueArtists: [String: CustomCellModel] = [:]

        for result in results {
            if uniqueArtists[result.subtitle] == nil {
                uniqueArtists[result.subtitle] = result
            }
        }

        return Array(uniqueArtists.values)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else {
            return
        }

        let networkService = NetworkService()
        networkService.fetchMusic(keyword: keyword) { [weak self] result in
            switch result {
            case .success(let musicResults):
                Music.shared.musicSearch = musicResults
                DispatchQueue.main.async {
                    var updatedCustomArray: [CustomCellModel] = []
                    for musicResult in musicResults {
                        let updatedModel = CustomCellModel(
                            avatarImageString: musicResult.artworkUrl100,
                            title: musicResult.trackName ?? "",
                            subtitle: musicResult.artistName,
                            album: musicResult.collectionName ?? "",
                            url: musicResult.previewUrl ?? ""
                        )
                        updatedCustomArray.append(updatedModel)
                    }
                    self?.customArray = updatedCustomArray
                    self?.performSearch(with: keyword)
                }

            case .failure(let error):
                print("Ошибка загрузки новых релизов:", error)
            }
        }
    }
}


// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
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
        return filteredArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultViewCell.cellId, for: indexPath) as? ResultViewCell else {
            fatalError()
        }

        cell.configureCell(model: filteredArray[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedSong = filteredArray[indexPath.row]
          let musicURL = selectedSong.url
          musicPlayer.loadPlayer(from: musicURL, playerType: .musicSearch)
          showMiniPlayer()
      }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]

        if let keyword = searchVC.searchBar.text {
            performSearch(with: keyword)
        }
    }
}

extension SearchViewController: MiniPlayerViewDelegate {
    func forwardButtonTapped() {
        musicPlayer.playNextSong()
    }

    func backwardButtonTapped() {
        musicPlayer.playPreviousSong()
    }

    func playButtonTapped() {
        musicPlayer.isPlayerPerforming() ? musicPlayer.pauseMusic() :  musicPlayer.playMusic()
    }
}

extension SearchViewController: MusicPlayerDelegate {

  func updateCurrentURL(_ url: String) {
    guard let musicResult = getMusicResultFromURL(url) else {
      miniPlayerVC.updateSongTitle("")
      miniPlayerVC.updateSongImage(nil)
      miniPlayerVC.updateSongArtist("")
      return
    }

    miniPlayerVC.updateSongTitle(musicResult.title)
    miniPlayerVC.updateSongArtist(musicResult.subtitle)
    if let imageUrl = URL(string: musicResult.avatarImageString), !url.isEmpty {
      URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        DispatchQueue.main.async {
          if let imageData = data, let image = UIImage(data: imageData) {
            self.miniPlayerVC.updateSongImage(image)
          } else {
            self.miniPlayerVC.updateSongImage(nil)
          }
        }
      }.resume()
    } else {
      miniPlayerVC.updateSongImage(nil)
    }
  }

  private func getMusicResultFromURL(_ url: String) -> CustomCellModel? {
      let musicResult = filteredArray.first { $0.url == url }
      return musicResult
  }

  func updatePlayButtonState(isPlaying: Bool) {
        DispatchQueue.main.async {
            if isPlaying {
              self.miniPlayerVC.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            } else {
              self.miniPlayerVC.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            }
          self.miniPlayerVC.playButton.tintColor = .brandBlack
        }
    }
}
