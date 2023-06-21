//
//  ExploreTopicViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 20.06.2023.
//

import UIKit

class AlbumTopicViewController: UIViewController {
    enum Constants {
        
    }
    
    //MARK: - Create UI
    
    private lazy var topicLabel = UILabel(text: "Hip Hop", font: .robotoBold18(), textColor: .neutralWhite)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        
    }
}

extension AlbumTopicViewController {
    private func setConstraints() {
        
    }
}
