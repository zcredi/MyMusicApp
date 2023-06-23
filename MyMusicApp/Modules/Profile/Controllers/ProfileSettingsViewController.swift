//
//  ProfileSettingsViewController.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 21.06.2023.
//

import UIKit
import SnapKit

class ProfileSettingsViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profileSettingsView = ProfileSettingsView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSettingsView.delegate = self
        configureVC()
        setViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}
   
// MARK: - Set Views and Setup Constraints
extension ProfileSettingsViewController {
    
    private func configureVC() {
        view.backgroundColor = .brandBlack
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.neutralWhite]
    }

    private func setViews() {
        view.addSubview(profileSettingsView)
    }
    
    private func setupConstraints() {
        profileSettingsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - ProfileViewDelegate
extension ProfileSettingsViewController: ProfileSettingsViewDelegate {
    
    func profileSettingsView(_ view: ProfileSettingsView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func profileSettingsView(_ view: ProfileSettingsView, cameraButtonPressed button: UIButton) {
        print("cameraButtonPressed")
    }
    
    func profileSettingsView(_ view: ProfileSettingsView, changePasswordButtonPressed button: UIButton) {
        let alertController = UIAlertController(title: "Change password",
                                                message: "Are you sure you want to change password?",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        let okAction = UIAlertAction(title: "Yes",
                                     style: .default) { (_) in
            self.changePassword()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func changePassword() {
//        let onboardingVC = HomepageViewController()
//        onboardingVC.modalPresentationStyle = .fullScreen
//        onboardingVC.modalTransitionStyle = .crossDissolve
//        self.present(onboardingVC, animated: true)
    }

}

