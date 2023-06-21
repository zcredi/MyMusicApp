//
//  ProfileViewController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profilelView = ProfileView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .brandBlack
        view.addSubview(profilelView)
    }
    
    private func addConstraints() {
        profilelView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
