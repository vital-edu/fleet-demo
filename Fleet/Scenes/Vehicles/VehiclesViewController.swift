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
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell else {
            return UITableViewCell()
        }

        cell.setup(leftTitle: "1444", rightTitle: "AAA", leftSubtitle: "Kostoni", rightSubtitle: "Estonia")

        return cell
    }
}
