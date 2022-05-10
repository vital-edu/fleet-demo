//
//  VehicleCell.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation
import UIKit

class VehicleCell: UITableViewCell, ViewConfiguration {
    static var identifier: String {
        return String(describing: self)
    }

    private struct ViewMetrics {
        static let margin = 16.0
        static let internalMargin = 16.0
    }

    private var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        return label
    }()

    private var leftSubtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private var rightTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        return label
    }()

    private var rightSubtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.addArrangedSubview(leftTitleLabel)
        stackView.addArrangedSubview(rightTitleLabel)
        return stackView
    }()

    private lazy var subtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.addArrangedSubview(leftSubtitleLabel)
        stackView.addArrangedSubview(rightSubtitleLabel)
        return stackView
    }()

    private lazy var mainView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = ViewMetrics.margin
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(subtitleStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    func buildViewHierarchy() {
        self.addSubview(mainView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: ViewMetrics.margin),
            mainView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: ViewMetrics.margin),
            mainView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -ViewMetrics.margin),
            mainView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -ViewMetrics.margin),
        ])
    }

    func setup(leftTitle: String, rightTitle: String, leftSubtitle: String, rightSubtitle: String) {
        leftTitleLabel.text = leftTitle
        leftSubtitleLabel.text = leftSubtitle
        rightTitleLabel.text = rightTitle
        rightSubtitleLabel.text = rightSubtitle
    }
}
