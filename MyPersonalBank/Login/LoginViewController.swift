//
//  ViewController.swift
//  MyPersonalBank
//
//  Created by Tatiana Dmitrieva on 20/01/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMassageLabel = UILabel()
    
    var userName: String? {
      loginView.usernameTextField.text
    }
    var userPassword: String? {
        loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)
        
        errorMassageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMassageLabel.textAlignment = .center
        errorMassageLabel.textColor = .red
        errorMassageLabel.numberOfLines = 0
        errorMassageLabel.isHidden = true
        
        
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMassageLabel)
        
        // Login View
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // Error Massage Label
        NSLayoutConstraint.activate([
            errorMassageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMassageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMassageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])

    }
}
// MARK: Actions
extension LoginViewController {
    
    @objc func signInButtonTapped() {
        errorMassageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = userName, let password = userPassword else {
           assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        if username == "User" && password == "welcom" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect Username / Password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMassageLabel.isHidden = false
        errorMassageLabel.text = message
        
    }
}

