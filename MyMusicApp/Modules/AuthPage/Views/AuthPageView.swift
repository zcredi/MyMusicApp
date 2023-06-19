//
//  AuthPageView.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 15.06.2023.
//

import UIKit
import Firebase

class AuthPageView: UIViewController {
    
    private lazy var smokeBackgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Smoke1")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        return view
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN"
        label.textColor = UIColor.white
        label.font = UIFont.robotoBold36()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let emailInput: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.neutralGray])
        textField.textColor = UIColor.neutralWhite
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
    
    let passwordInput: UITextField = {
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
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold16()
        button.setTitleColor(UIColor.brandBlack, for: .normal)
        button.backgroundColor = UIColor.brandGreen
        button.layer.cornerRadius = 4
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var optionsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "GroupMock")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = UIColor.white
        label.font = UIFont.robotoBold14()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold14()
        button.setTitleColor(UIColor.brandGreen, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToSignUpPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password ?", for: .normal)
        button.titleLabel?.font = UIFont.montserrat14()
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToForgotPasswordPage), for: .touchUpInside)
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
        view.addSubview(signInLabel)
        view.addSubview(emailInput)
        view.addSubview(mailImage)
        view.addSubview(emailLineImage)
        view.addSubview(passwordInput)
        view.addSubview(lockImage)
        view.addSubview(passwordLineImage)
        view.addSubview(forgotPasswordButton)
        view.addSubview(eyeImage)
        view.addSubview(signInButton)
        view.addSubview(optionsImage)
        view.addSubview(questionLabel)
        view.addSubview(signUpButton)
    }
    
    @objc func togglePasswordVisibility() {
        passwordInput.isSecureTextEntry.toggle()
    }

    @objc func goToForgotPasswordPage() {
        let forgotPasswordVC = ForgotPasswordPageView()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }

    @objc func goToSignUpPage() {
        let signUpVC = SignUpPageView()
        navigationController?.pushViewController(signUpVC, animated: true)
    }

    @objc func signInPressed() {

        if let email = emailInput.text, let password = passwordInput.text {

            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in

                if let e = error {
                    let ac = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    self.present(ac, animated: true, completion: nil)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    ac.addAction(okAction)
                    return
                } else {
                    let homePageVC = HomepageViewController()
                    self.navigationController?.pushViewController(homePageVC, animated: true)
                }

            }

        }

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
            
            signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            emailInput.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 70),
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
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 36),
            forgotPasswordButton.bottomAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: -64),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordLineImage.trailingAnchor),

            eyeImage.topAnchor.constraint(equalTo: passwordInput.topAnchor),
            eyeImage.leadingAnchor.constraint(equalTo: passwordInput.trailingAnchor),
            eyeImage.trailingAnchor.constraint(equalTo: passwordLineImage.trailingAnchor),
            eyeImage.heightAnchor.constraint(equalToConstant: 17.69),
            eyeImage.widthAnchor.constraint(equalToConstant: 17.69),
            
            signInButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 120),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            signInButton.widthAnchor.constraint(equalToConstant: 295),
            
            optionsImage.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 140),
            optionsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            optionsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            optionsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionsImage.heightAnchor.constraint(equalToConstant: 46),
            optionsImage.widthAnchor.constraint(equalToConstant: 295),

            questionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88),
            
            signUpButton.topAnchor.constraint(equalTo: questionLabel.topAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            signUpButton.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 5),
        
        ])

    }

    
}
