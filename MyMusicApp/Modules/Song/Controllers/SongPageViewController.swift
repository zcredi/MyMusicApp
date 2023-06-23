//
//  PageViewController.swift
//  MyMusicApp
//
//  Created by Евгений on 14.06.2023.
//

import UIKit

final class SongPageViewController: UIPageViewController {
    
    var trackInfo: Entry? {
        didSet {
            if let trackInfo = trackInfo {
                songVC.configureCell(with: trackInfo)
                albumVC.configureCell(with: trackInfo)
            }
        }
    }
    
    let songVC = SongViewController()
    let albumVC = AlbumViewController()
    
    
    lazy var controllers: [UIViewController] = {
        var controllers = [UIViewController]()
        
        controllers.append(songVC)
        controllers.append(albumVC)
        
        return controllers
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        setViewControllers([controllers[0]], direction: .forward, animated: true)
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteViewController(controller: FavoritesViewControllerProtocol) {
        songVC.favoriteVC = controller
    }
}

extension SongPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
            
        }
        
        return nil
    }
}
