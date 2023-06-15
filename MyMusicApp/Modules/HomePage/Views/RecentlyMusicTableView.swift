//
//  RecentlyMusic.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 12.06.2023.
//

import UIKit

class RecentlyMusicTableView: UITableView {

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
}

// MARK: - TableView Delegate
extension RecentlyMusicTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else {
          return UITableViewCell()
      }
      let songNumber = indexPath.row
      cell.configureCell(with: songs[indexPath.row], songNumber: songNumber)
      return cell
  }
}
