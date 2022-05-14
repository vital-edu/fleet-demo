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
    }

    private var bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        buildLayout()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.refresh(from: self)
    }

    func configureViews() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }

    func buildViewHierarchy() {
        view.addSubview(bottomTitleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomTitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ViewMetrics.bottomPadding)
        ])
    }

    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        navigationItem.title = viewModel.navigationTitle

        viewModel.bottomTitle.bindAndFire { [weak self] text in
            guard let self = self else { return }
            self.bottomTitleLabel.text = text
            self.view.bringSubviewToFront(self.bottomTitleLabel)
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
            let startPosition = CLLocationCoordinate2D(
                latitude: firtPosition.latitude,
                longitude: firtPosition.longitude
            )
            let endPosition = CLLocationCoordinate2D(
                latitude: firtPosition.latitude,
                longitude: lastPosition.longitude
            )

            // add camera
            let camera = GMSCameraPosition.camera(
                withLatitude: startPosition.latitude,
                longitude: startPosition.longitude,
                zoom: 14
            )
            let safeAreaInsets = self.view.safeAreaInsets
            let mapView = GMSMapView.map(
                withFrame: self.view.bounds.inset(
                    by: UIEdgeInsets(
                        top: safeAreaInsets.top,
                        left: safeAreaInsets.left,
                        bottom: .zero,
                        right: safeAreaInsets.right)
                    ),
                camera: camera
            )
            self.view.addSubview(mapView)

            // add start marker
            let startMarker = GMSMarker()
            startMarker.position = CLLocationCoordinate2D(
                latitude: startPosition.latitude,
                longitude: startPosition.longitude
            )
            startMarker.title = viewModel.startMarkerTitle
            startMarker.map = mapView

            // add end marker
            let endMarker = GMSMarker()
            endMarker.position = CLLocationCoordinate2D(
                latitude: endPosition.latitude,
                longitude: endPosition.longitude
            )
            endMarker.title = viewModel.endMarkerTitle
            endMarker.map = mapView

            // add location path
            let path = GMSMutablePath()
            for position in positions {
                path.addLatitude(position.latitude, longitude: position.longitude)
            }
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .blue
            polyline.strokeWidth = 2
            polyline.map = mapView

            let bounds = GMSCoordinateBounds(coordinate: startPosition, coordinate: endPosition)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
            mapView.moveCamera(update)
        }
    }
}
