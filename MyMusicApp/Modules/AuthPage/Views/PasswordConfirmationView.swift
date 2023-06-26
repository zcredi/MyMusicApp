//
//  PasswordConfirmationView.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 16.06.2023.
//

import UIKit
import Firebase

class PasswordConfirmationView: UIViewController {
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textColor = UIColor.white
        label.font = UIFont.robotoBold28()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "If you need help resetting your password, we can help by sending you a link to reset it."
        label.textColor = UIColor.neutralGray
        label.font = UIFont.montserrat12()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.neutralGray])
        textField.textColor = UIColor.neutralWhite
        textField.font = UIFont.montserrat14()
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lock")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var passwordLineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Line")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    private lazy var eyeImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye-17"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private let confirmPasswordInput: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.neutralGray])
        textField.textColor = UIColor.neutralWhite
        textField.font = UIFont.montserrat14()
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmPasswordLockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lock")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var confirmPasswordLineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Line")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    private lazy var confirmPasswordEyeImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye-17"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePasswordVisibility2), for: .touchUpInside)
        return button
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("CHANGE PASSWORD", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold16()
        button.setTitleColor(UIColor.brandBlack, for: .normal)
        button.backgroundColor = UIColor.brandGreen
        button.layer.cornerRadius = 4
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changePasswordPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        view.backgroundColor = UIColor.brandBlack
    }
}

// MARK: - setupView, setConstraints
extension PasswordConfirmationView {
    
    private func setupView() {
        view.addSubview(forgotPasswordLabel)
        view.addSubview(informationLabel)
        view.addSubview(passwordInput)
        view.addSubview(lockImage)
        view.addSubview(passwordLineImage)
        view.addSubview(eyeImage)
        view.addSubview(confirmPasswordInput)
        view.addSubview(confirmPasswordLockImage)
        view.addSubview(confirmPasswordLineImage)
        view.addSubview(confirmPasswordEyeImage)
        view.addSubview(changePasswordButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            informationLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.topAnchor, constant: 55),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            informationLabel.widthAnchor.constraint(equalToConstant: 300),
            informationLabel.heightAnchor.constraint(equalToConstant: 72),
            
            passwordInput.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 90),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            lockImage.topAnchor.constraint(equalTo: passwordInput.topAnchor),
            lockImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            lockImage.trailingAnchor.constraint(equalTo: passwordInput.leadingAnchor, constant: -50),
            lockImage.heightAnchor.constraint(equalToConstant: 17.69),
            lockImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            passwordLineImage.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            passwordLineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordLineImage.trailingAnchor.constraint(equalTo: passwordInput.leadingAnchor, constant: -50),
            passwordLineImage.widthAnchor.constraint(equalToConstant: 295),
            
            eyeImage.topAnchor.constraint(equalTo: passwordInput.topAnchor),
            eyeImage.leadingAnchor.constraint(equalTo: passwordInput.trailingAnchor),
            eyeImage.trailingAnchor.constraint(equalTo: passwordLineImage.trailingAnchor),
            eyeImage.heightAnchor.constraint(equalToConstant: 17.69),
            eyeImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            confirmPasswordInput.topAnchor.constraint(equalTo: passwordLineImage.bottomAnchor, constant: 38),
            confirmPasswordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            confirmPasswordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            confirmPasswordLockImage.topAnchor.constraint(equalTo: passwordLineImage.bottomAnchor, constant: 38),
            confirmPasswordLockImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordLockImage.trailingAnchor.constraint(equalTo: passwordInput.leadingAnchor, constant: -50),
            confirmPasswordLockImage.heightAnchor.constraint(equalToConstant: 17.69),
            confirmPasswordLockImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            confirmPasswordLineImage.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 10),
            confirmPasswordLineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordLineImage.trailingAnchor.constraint(equalTo: confirmPasswordInput.leadingAnchor, constant: -50),
            confirmPasswordLineImage.widthAnchor.constraint(equalToConstant: 295),
            
            confirmPasswordEyeImage.topAnchor.constraint(equalTo: confirmPasswordInput.topAnchor),
            confirmPasswordEyeImage.leadingAnchor.constraint(equalTo: confirmPasswordInput.trailingAnchor),
            confirmPasswordEyeImage.trailingAnchor.constraint(equalTo: confirmPasswordLineImage.trailingAnchor),
            confirmPasswordEyeImage.heightAnchor.constraint(equalToConstant: 17.69),
            confirmPasswordEyeImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            changePasswordButton.topAnchor.constraint(equalTo: confirmPasswordLineImage.bottomAnchor, constant: 64),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            changePasswordButton.trailingAnchor.constraint(equalTo: confirmPasswordLineImage.trailingAnchor),
            changePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 46),
            changePasswordButton.widthAnchor.constraint(equalToConstant: 295)
        ])
    }
}

// MARK: - Target methods
extension PasswordConfirmationView {
    
    @objc func togglePasswordVisibility() {
        passwordInput.isSecureTextEntry.toggle()
    }
    
    @objc func togglePasswordVisibility2() {
        confirmPasswordInput.isSecureTextEntry.toggle()
    }
    
    @objc func changePasswordPressed() {
        if let password = passwordInput.text, let confirmedPassword = confirmPasswordInput.text {
            
            if password != confirmedPassword {
                let ac = UIAlertController(title: "Error", message: "Passwords are not equal!", preferredStyle: .alert)
                self.present(ac, animated: true, completion: nil)
                let okAction = UIAlertAction(title: "OK", style: .default)
                okAction.setValue(UIColor.brandGreen, forKey: "titleTextColor")
                ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .neutralGray
                ac.addAction(okAction)
                return
            } else {
                FirebaseManager.shared.updatePassword(to: password) { error in
                }
                
                if self.presentingViewController != nil {
                    self.dismiss(animated: true)
                } else {
                    let signInVC = AuthPageView()
                    self.navigationController?.pushViewController(signInVC, animated: true)
                }
            }
        }
    }
}
