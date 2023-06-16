//
//  ForgorPasswordPageView.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 16.06.2023.
//

import UIKit

class ForgotPasswordPageView: UIViewController {
    
    private lazy var backArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)
        return button
    }()
    
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

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("SEND", for: .normal)
        button.titleLabel?.font = UIFont.robotoBold16()
        button.setTitleColor(UIColor.brandBlack, for: .normal)
        button.backgroundColor = UIColor.brandGreen
        button.layer.cornerRadius = 4
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToPasswordConfirmationPage), for: .touchUpInside)
        return button
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor.brandBlack
    }

    private func setupView() {
        view.addSubview(backArrowButton)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(informationLabel)
        view.addSubview(emailInput)
        view.addSubview(mailImage)
        view.addSubview(emailLineImage)
        view.addSubview(sendButton)
        
    }
    
    @objc func goToSignInPage() {
        let signInVC = AuthPageView()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func goToPasswordConfirmationPage() {
        let passwordConfirmationVC = PasswordConfirmationView()
        navigationController?.pushViewController(passwordConfirmationVC, animated: true)
    }

    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            backArrowButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            backArrowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backArrowButton.heightAnchor.constraint(equalToConstant: 32),
            backArrowButton.widthAnchor.constraint(equalToConstant: 32),
        
            forgotPasswordLabel.topAnchor.constraint(equalTo: backArrowButton.bottomAnchor, constant: 32),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            informationLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.topAnchor, constant: 55),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            informationLabel.widthAnchor.constraint(equalToConstant: 300),
            informationLabel.heightAnchor.constraint(equalToConstant: 72),
            
            emailInput.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 90),
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
            
            sendButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 64),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 46),
            sendButton.widthAnchor.constraint(equalToConstant: 295),
            
        
        ])

    }
}
