//
//  SignUpPageView.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 15.06.2023.
//

import UIKit

class SignUpPageView: UIViewController {
    
    private lazy var smokeBackgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Smoke2")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        return view
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN UP"
        label.textColor = UIColor.white
        label.font = UIFont.robotoBold36()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = UIFont.montserrat14()
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    private let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.font = UIFont.montserrat14()
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var mailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mail")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var emailLineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Line")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image

    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
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
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold16()
        button.setTitleColor(UIColor.brandBlack, for: .normal)
        button.backgroundColor = UIColor.brandGreen
        button.layer.cornerRadius = 4
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToHomePage), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold16()
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)
        return button
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        navigationItem.hidesBackButton = true
    }

    private func setupView() {
        view.addSubview(smokeBackgroundImage)
        view.addSubview(overlayView)
        view.addSubview(signUpLabel)
        view.addSubview(nameInput)
        view.addSubview(profileImage)
        view.addSubview(emailInput)
        view.addSubview(mailImage)
        view.addSubview(emailLineImage)
        view.addSubview(passwordInput)
        view.addSubview(lockImage)
        view.addSubview(passwordLineImage)
        view.addSubview(eyeImage)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
    }
    
    @objc func togglePasswordVisibility() {
        passwordInput.isSecureTextEntry.toggle()
    }

    
    @objc func goToSignInPage() {
        let signInVC = AuthPageView()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func goToHomePage() {
        let homePageVC = HomepageViewController()
        navigationController?.pushViewController(homePageVC, animated: true)
    }


    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            smokeBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            smokeBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            smokeBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            smokeBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            overlayView.topAnchor.constraint(equalTo: smokeBackgroundImage.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: smokeBackgroundImage.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: smokeBackgroundImage.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: smokeBackgroundImage.trailingAnchor),
            
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            nameInput.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 70),
            nameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            nameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            profileImage.topAnchor.constraint(equalTo: nameInput.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            profileImage.trailingAnchor.constraint(equalTo: nameInput.leadingAnchor, constant: -50),
            profileImage.heightAnchor.constraint(equalToConstant: 17.69),
            profileImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            emailInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 70),
            emailInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            emailInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            mailImage.topAnchor.constraint(equalTo: emailInput.topAnchor),
            mailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mailImage.trailingAnchor.constraint(equalTo: emailInput.leadingAnchor, constant: -50),
            mailImage.heightAnchor.constraint(equalToConstant: 17.69),
            mailImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            emailLineImage.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 10),
            emailLineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailLineImage.trailingAnchor.constraint(equalTo: emailInput.leadingAnchor, constant: -50),
            emailLineImage.widthAnchor.constraint(equalToConstant: 295),
            
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 70),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            
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
            
            signUpButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 64),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 46),
            signUpButton.widthAnchor.constraint(equalToConstant: 295),
            
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 27),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            signInButton.widthAnchor.constraint(equalToConstant: 295),

        
        ])

    }
}
