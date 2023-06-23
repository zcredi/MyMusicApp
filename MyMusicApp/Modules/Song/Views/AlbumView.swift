//
//  AlbumView.swift
//  MyMusicApp
//
//  Created by Евгений on 13.06.2023.
//

import UIKit

final class AlbumView {
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SongImage1")
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy var albumPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.layer.cornerRadius = 1.5
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .neutralGray
        pageControl.frame = CGRect(x: 0, y: 0, width: 45, height: 3)
        
        return pageControl
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .systemGray.withAlphaComponent(0.5)
        label.numberOfLines = 1
        label.text = "Come to me"
        label.font = .robotoBold36()
        label.textColor = .neutralWhite
        
        return label
    }()
    
    lazy var performerNameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .systemGray.withAlphaComponent(0.5)
        label.text = "One Republic"
        label.font = .robotoRegular18()
        label.textColor = .neutralWhite
        
        return label
    }()
    
    lazy var describingSongLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .systemGray.withAlphaComponent(0.5)
        
        DispatchQueue.main.async {
            label.addTrailing(with: "...",
                              moreText: "Show more ∨",
                              moreTextFont: .robotoRegular14() ?? .systemFont(ofSize: 14),
                              moreTextColor: .neutralGray)
        }
        
        label.text = """
        ADA France,Distributed by Warner Music France \nADA France,
        Distributed by Warner Music France\nADA France,
        Distributed by Warner Music France
        """
        
        label.font = .robotoRegular14()
        label.textColor = .neutralWhite
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    lazy var separatororLine: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralGray
        
        return view
    }()
}
