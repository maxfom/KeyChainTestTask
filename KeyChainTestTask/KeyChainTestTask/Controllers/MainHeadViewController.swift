//
//  MainHeadViewController.swift
//  KeyChainTestTask
//
//  Created by Максим Фомичев on 22.10.2021.
//

import UIKit
import KeychainAccess

class MainHeadViewController: UIViewController {
    
    let backToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back to login", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        navigationController?.isNavigationBarHidden = true
        backToLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    }
    
    @objc func loginButtonTapped() {
        pushControllers(vc: LoginViewController())
        navigationController?.isNavigationBarHidden = true
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MainHeadViewController {
    
    
    func setConstraints() {
    
        view.addSubview(backToLoginButton)
        NSLayoutConstraint.activate([
            backToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            backToLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            backToLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            backToLoginButton.heightAnchor.constraint(equalToConstant: 22),
            backToLoginButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
}
