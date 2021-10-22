//
//  UsersTableViewController.swift
//  KeyChainTestTask
//
//  Created by Максим Фомичев on 22.10.2021.
//
import UIKit
import KeychainAccess

class UsersTableViewController: UITableViewController {
    var itemsGroupedByService: [String: [[String: Any]]]?
    
    let idUsersTableCell = "idUsersTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Data"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: idUsersTableCell)
        tableView.separatorStyle = .none
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        reloadData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:
    override func numberOfSections(in tableView: UITableView) -> Int {
        if itemsGroupedByService != nil {
            let services = Array(itemsGroupedByService!.keys)
            return services.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let services = Array(itemsGroupedByService!.keys)
        let service = services[section]

        let items = Keychain(service: service).allItems()
        return items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let services = Array(itemsGroupedByService!.keys)
        return services[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idUsersTableCell", for: indexPath) as! UsersTableViewCell
        let services = Array(itemsGroupedByService!.keys)
        let service = services[indexPath.section]

        let items = Keychain(service: service).allItems()
        let item = items[indexPath.row]

        cell.nameCellLabel.text = item["key"] as? String
        cell.passCellLabel.text = item["value"] as? String

        return cell
    }

    #if swift(>=4.2)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let services = Array(itemsGroupedByService!.keys)
        let service = services[indexPath.section]

        let keychain = Keychain(service: service)
        let items = keychain.allItems()

        let item = items[indexPath.row]
        let key = item["key"] as! String

        keychain[key] = nil

        if items.count == 1 {
            reloadData()
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    #else
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let services = Array(itemsGroupedByService!.keys)
        let service = services[indexPath.section]

        let keychain = Keychain(service: service)
        let items = keychain.allItems()

        let item = items[indexPath.row]
        let key = item["key"] as! String

        keychain[key] = nil

        if items.count == 1 {
            reloadData()
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    #endif


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
