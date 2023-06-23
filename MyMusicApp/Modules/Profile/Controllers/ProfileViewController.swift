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
    private let profileView = ProfileView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
        configureVC()
        setViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Set Views and Setup Constraints
extension ProfileViewController {
    
    private func configureVC() {
        view.backgroundColor = .brandBlack
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.neutralWhite]
    }
    
    private func setViews() {
        view.addSubview(profileView)
    }
    
    private func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    
    func profileView(_ view: ProfileView,  settingsButtonPressed button: UIButton) {
        let profileSettingsVC = ProfileSettingsViewController()
        profileSettingsVC.modalPresentationStyle = .fullScreen
        profileSettingsVC.modalTransitionStyle = .crossDissolve
        self.present(profileSettingsVC, animated: true)
    }
    
    func profileView(_ view: ProfileView, signOutButtonPressed button: UIButton) {
        let alertController = UIAlertController(title: "Sign out",
                                                message: "Are you sure you want to sign out of your profile?",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        let okAction = UIAlertAction(title: "Yes",
                                     style: .default) { (_) in
            self.signOut()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
//        let onboardingVC = HomepageViewController()
//        onboardingVC.modalPresentationStyle = .fullScreen
//        onboardingVC.modalTransitionStyle = .crossDissolve
//        self.present(onboardingVC, animated: true)
    }
}

