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
        FirebaseManager.shared.downloadProfileImage { image, error in
            self.profileView.profileImage.image = image
        }
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
        
        cancelAction.setValue(UIColor.brandGreen, forKey: "titleTextColor")
        okAction.setValue(UIColor.brandGreen, forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .neutralGray
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        FirebaseManager.shared.signOut {
            let authPageVC = AuthPageView()
            authPageVC.modalPresentationStyle = .fullScreen
            authPageVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(authPageVC, animated: true)
        }
    }
}

