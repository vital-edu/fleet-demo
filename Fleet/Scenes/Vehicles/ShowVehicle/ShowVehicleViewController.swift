//
//  ShowVehicleViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import UIKit
import GoogleMaps

class ShowVehicleViewController: UIViewController, ViewConfiguration {
    var viewModel: ShowVehicleViewModel?

    private struct ViewMetrics {
        static let bottomPadding = 16.0
        static let searchBarTopPadding = 8.0
        static let mapCameraPadding = 100.0
        static let mapStrokeWidth = 2.0
    }

    private lazy var mapView: GMSMapView = {
        let safeAreaInsets = self.view.safeAreaInsets
        let map = GMSMapView.map(
            withFrame: self.view.bounds.inset(by: UIEdgeInsets(
                top: safeAreaInsets.top,
                left: safeAreaInsets.left,
                bottom: .zero,
                right: safeAreaInsets.right)
            ),
            camera: GMSCameraPosition()
        )
        return map
    }()

    private var bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        return label
    }()

    private lazy var searchOptionsView: SearchOptionsView = {
        let view = SearchOptionsView { [weak self] date in
            guard let self = self else { return }
            self.viewModel?.fetchVehiclePositions(at: date, viewController: self)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        buildLayout()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.fetchVehiclePositions(at: searchOptionsView.date, viewController: self)
    }

    func configureViews() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }

    func buildViewHierarchy() {
        view.addSubview(mapView)
        view.addSubview(bottomTitleLabel)
        view.addSubview(searchOptionsView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomTitleLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -ViewMetrics.bottomPadding
            ),

            searchOptionsView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: ViewMetrics.searchBarTopPadding
            ),
            searchOptionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchOptionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        navigationItem.title = viewModel.navigationTitle

        viewModel.bottomTitle.bindAndFire { [weak self] text in
            guard let self = self else { return }
            self.bottomTitleLabel.text = text
        }

        viewModel.positions.bindAndFire { [weak self] positions in
            guard
                let self = self,
                let viewModel = self.viewModel,
                let firtPosition = positions.first,
                let lastPosition = positions.last
            else {
                return
            }
            self.mapView.clear()

            let startPosition = CLLocationCoordinate2D(
                latitude: firtPosition.latitude,
                longitude: firtPosition.longitude
            )
            let endPosition = CLLocationCoordinate2D(
                latitude: firtPosition.latitude,
                longitude: lastPosition.longitude
            )

            // add start marker
            let startMarker = GMSMarker()
            startMarker.position = CLLocationCoordinate2D(
                latitude: startPosition.latitude,
                longitude: startPosition.longitude
            )
            startMarker.title = viewModel.startMarkerTitle
            startMarker.map = self.mapView

            // add end marker
            let endMarker = GMSMarker()
            endMarker.position = CLLocationCoordinate2D(
                latitude: endPosition.latitude,
                longitude: endPosition.longitude
            )
            endMarker.title = viewModel.endMarkerTitle
            endMarker.map = self.mapView

            // add location path
            let path = GMSMutablePath()
            for position in positions {
                path.addLatitude(position.latitude, longitude: position.longitude)
            }
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .blue
            polyline.strokeWidth = 2
            polyline.map = self.mapView

            let bounds = GMSCoordinateBounds(coordinate: startPosition, coordinate: endPosition)
            let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: ViewMetrics.mapCameraPadding)
            self.mapView.moveCamera(cameraUpdate)
        }
    }
}
