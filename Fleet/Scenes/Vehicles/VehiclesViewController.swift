//
//  VehiclesViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import UIKit

class VehiclesViewController: BaseViewController, ViewConfiguration {
    var viewModel: VehiclesViewModelProtocol? {
        didSet { setupUI() }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        setupNavigationBar()
        setupUI()
        viewModel?.refresh(from: self)
    }

    private func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh"), style: .done, target: self, action: #selector(refresh))
        let apiKeyButton = UIBarButtonItem(image: UIImage(named: "key"), style: .plain, target: self, action: #selector(changeApiKey))

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

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    @objc private func refresh() {
        viewModel?.refresh(from: self)
    }

    @objc private func changeApiKey() {
        viewModel?.changeApiKey(from: self)
    }
}

extension VehiclesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as? VehicleCell, let item = viewModel?.items.value[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setup(leftTitle: item.leftTitle, rightTitle: item.rightTitle, leftSubtitle: item.leftSubtitle, rightSubtitle: item.rightSubtitle)

        return cell
    }
}

extension VehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelect(row: indexPath.row, from: self)
    }
}
