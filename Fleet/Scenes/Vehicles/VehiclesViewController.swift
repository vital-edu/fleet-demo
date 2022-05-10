//
//  VehiclesViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import UIKit

class VehiclesViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: VehicleCell.identifier)

        cell.textLabel?.text = "14444 / AAAAA"
        cell.detailTextLabel?.text = "Kostoni, Tortu, Estnonia"

        return cell
    }
}
