//
//  RecentlyMusic.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 12.06.2023.
//

import UIKit

class RecentlyMusicTableView: UITableView {
    
    private var recentlyArray = [RecentlyModel]()
    
    var songs: [Entry] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTable()
    }
    
    func configureTable() {
        rowHeight = 60
        separatorStyle = .none
        backgroundColor = .clear
        register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.identifier)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with musicResults: [Entry]) {
        songs = musicResults
    }
    
    public func setRecentlyArray(_ array: [RecentlyModel]) {
        recentlyArray = array
    }
}

// MARK: - TableView Delegate
extension RecentlyMusicTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentlyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else {
            return UITableViewCell()
        }
        let songNumber = indexPath.row + 1
        let recentlyModel = recentlyArray[indexPath.row]
        cell.configure(model: recentlyModel, songNumber: songNumber)
        return cell
    }
}
