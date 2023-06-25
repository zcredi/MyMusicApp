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
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSettingsView.delegate = self
        imagePicker.delegate = self
        configureVC()
        setViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}
   
// MARK: - Set Views, Setup Constraints, Update UserInfo
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
    
    private func updateUserInfo() {
        guard let name = FirebaseManager.shared.getFromUserDefaultsUserInfo()?.name,
              let email = FirebaseManager.shared.getFromUserDefaultsUserInfo()?.email else { return }
        profileSettingsView.usernameView.usernameTextField.text = name
        profileSettingsView.emailView.emailTextField.text = email
    }
}

// MARK: - ProfileViewDelegate
extension ProfileSettingsViewController: ProfileSettingsViewDelegate {
    
    func profileSettingsView(_ view: ProfileSettingsView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func profileSettingsView(_ view: ProfileSettingsView, cameraButtonPressed button: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
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
        
        cancelAction.setValue(UIColor.brandGreen, forKey: "titleTextColor")
        okAction.setValue(UIColor.brandGreen, forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .neutralGray
        present(alertController, animated: true, completion: nil)
    }
    
    func changePassword() {
        let passwordConfirmationVC = PasswordConfirmationView()
        passwordConfirmationVC.modalPresentationStyle = .formSheet
        self.present(passwordConfirmationVC, animated: true)
    }

}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ProfileSettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        profileSettingsView.profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
