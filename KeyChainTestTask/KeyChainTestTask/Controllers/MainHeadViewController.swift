//
//  MainHeadViewController.swift
//  KeyChainTestTask
//
//  Created by Максим Фомичев on 22.10.2021.
//

import UIKit
import KeychainAccess

class MainHeadViewController: UIViewController {
    
    var itemsGroupedByService: [String: [[String: Any]]]?
    
    let helloLabel = UILabel(text: "Hello, this is Start Screen", font: .AvenirNextDemiBold20(), aligment: .natural)

    
    let backToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout and sing in", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        checkAuth()
        view.backgroundColor = .white
        setConstraints()
        navigationController?.isNavigationBarHidden = true
        backToLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func loginButtonTapped() {
        pushControllers(vc: LoginViewController())
        navigationController?.isNavigationBarHidden = true
    }
    
    func checkAuth() {
        let services = Array(itemsGroupedByService!.keys)
        if services.count == 0 {
            pushControllers(vc: LoginViewController())
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: reloadData
    
    func reloadData() {
        let items = Keychain.allItems(.genericPassword)
        itemsGroupedByService = groupBy(items) { item -> String in
            if let service = item["service"] as? String {
                return service
            }
            return ""
        }
    }
}

private func groupBy<C: Collection, K: Hashable>(_ xs: C, key: (C.Iterator.Element) -> K) -> [K:[C.Iterator.Element]] {
    var gs: [K:[C.Iterator.Element]] = [:]
    for x in xs {
        let k = key(x)
        var ys = gs[k] ?? []
        ys.append(x)
        gs.updateValue(ys, forKey: k)
    }
    return gs
}


extension MainHeadViewController {
    
    
    func setConstraints() {
        
        view.addSubview(helloLabel)
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            helloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            helloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        view.addSubview(backToLoginButton)
        NSLayoutConstraint.activate([
            backToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            backToLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            backToLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            backToLoginButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
    }
    
}
