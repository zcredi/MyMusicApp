//
//  AuthPageController.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 19.06.2023.
//

import UIKit
import Firebase

class AuthPageController {
    
    var authPageView = AuthPageView()
    
    @objc func togglePasswordVisibility() {
        authPageView.passwordInput.isSecureTextEntry.toggle()
    }
    
    @objc func goToForgotPasswordPage() {
        let forgotPasswordVC = ForgotPasswordPageView()
        authPageView.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc func goToSignUpPage() {
        let signUpVC = SignUpPageView()
        authPageView.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func signInPressed() {
        
        if let email = authPageView.emailInput.text, let password = authPageView.passwordInput.text {
        
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error {
                    let ac = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    self.authPageView.present(ac, animated: true, completion: nil)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    ac.addAction(okAction)
                    return
                } else {
                    let homePageVC = HomepageViewController()
                    self.authPageView.navigationController?.pushViewController(homePageVC, animated: true)
                }
            
            }
        
        }

    }
}
