//
//  ViewController.swift
//  KeyChainTestTask
//
//  Created by Максим Фомичев on 22.10.2021.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
        
    let loginLabel = UILabel(text: "Login:", font: .AvenirNext14(), aligment: .left)
    var loginField = UITextField(placeholder: "Enter your login", keyboardType: .default, font: .AvenirNextDemiBold14())
    let passwordLabel = UILabel(text: "Password:", font: .AvenirNext14(), aligment: .left)
    var passwordField = UITextField(placeholder: "Enter your password", keyboardType: .default, font: .AvenirNextDemiBold14())
    
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return button
    }()
    
    let showUsersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Users Data", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log in"
        setConstraints()
        passwordField.isSecureTextEntry = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        showUsersButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func loginButtonTapped() {
        if loginField.hasText && passwordField.hasText {
            saveAction()
            pushControllers(vc: MainHeadViewController())
        }
        else {
            print("Input symbols")
        }
    }
    
    @objc func showButtonTapped() {
        pushControllers(vc: UsersTableViewController())
    }
    
    
    func saveAction() {
        let keychain: Keychain
        if let service = loginField.text, !service.isEmpty {
            keychain = Keychain(service: service)
        } else {
            keychain = Keychain()
        }
        keychain[loginField.text!] = passwordField.text
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension LoginViewController {
    
    
    func setConstraints() {
        
        view.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            loginLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        view.addSubview(loginField)
        NSLayoutConstraint.activate([
            loginField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            loginField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 30),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            passwordLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            passwordField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        view.addSubview(showUsersButton)
        NSLayoutConstraint.activate([
            showUsersButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            showUsersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            showUsersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            showUsersButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
    }
    
}

