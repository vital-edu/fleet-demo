//
//  DatePickerViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 14/05/2022.
//

import UIKit

class DatePickerViewController: UIViewController, ViewConfiguration {
    private struct ViewMetrics {
        static let doneTopPadding = 8.0
        static let doneTrailingPadding = 4.0
        static let datePickerTopPadding = 8.0
        static let datePickerBottomPadding = 8.0
        static let datePickerLeadingPadding = 8.0
        static let datePickerTrailingPadding = 8.0
    }

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(updateDate), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var onUpdateDate: ((Date) -> Void)?

    @objc private func updateDate() {
        onUpdateDate?(datePicker.date)
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    func buildViewHierarchy() {
        view.addSubview(doneButton)
        view.addSubview(datePicker)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: ViewMetrics.datePickerTopPadding
            ),
            datePicker.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: ViewMetrics.datePickerLeadingPadding
            ),
            datePicker.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: ViewMetrics.datePickerTrailingPadding
            ),
            datePicker.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: ViewMetrics.datePickerBottomPadding
            ),
        ])
    }
}
