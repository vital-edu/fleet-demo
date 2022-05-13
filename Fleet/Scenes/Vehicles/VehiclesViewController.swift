//
//  VehiclesViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import UIKit

class VehiclesViewController: UITableViewController {
    var viewModel: VehiclesViewModelProtocol? {
        didSet { setupUI() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupUI()
        viewModel?.refresh(from: self)
    }

    private func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh"), style: .done, target: self, action: #selector(refresh))
        let apiKeyButton = UIBarButtonItem(image: UIImage(named: "key"), style: .plain, target: self, action: #selector(changeApiKey))

        refreshButton.tintColor = .black
        apiKeyButton.tintColor = .black
        navigationItem.leftBarButtonItem = refreshButton
        navigationItem.rightBarButtonItem = apiKeyButton
    }

    private func setupUI() {
        guard isViewLoaded, let viewModel = viewModel else { return }
        navigationItem.title = viewModel.navigationTitle
        viewModel.items.bind({ [weak self] items in
            guard let self = self else { return }
            self.tableView.reloadData()
        })
    }

    @objc private func refresh() {
        viewModel?.refresh(from: self)
    }

    @objc private func changeApiKey() {
        viewModel?.changeApiKey(from: self)
    }

    private func setupTableView() {
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell, let item = viewModel?.items.value[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setup(leftTitle: item.leftTitle, rightTitle: item.rightTitle, leftSubtitle: item.leftSubtitle, rightSubtitle: item.rightSubtitle)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(row: indexPath.row, from: self)
    }
}
