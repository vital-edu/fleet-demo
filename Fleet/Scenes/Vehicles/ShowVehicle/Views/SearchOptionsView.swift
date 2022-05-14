//
//  SearchOptionsView.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 14/05/2022.
//

import UIKit

class SearchOptionsView: UIView, ViewConfiguration {
    private struct ViewMetrics {
        static let spacing = 16.0
        static let topMargin = 8.0
        static let bottomMargin = 8.0
        static let leadingMargin = 16.0
        static let trailingMargin = 16.0
    }

    private let dateFormatter = DateUtils.dayMonthYearFormatter

    private lazy var hiddenTextField: UITextField = {
        let textField = UITextField()

        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        let cancel = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dissmissDatePicker)
        )
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let save = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveDate)
        )

        toolbar.items = [cancel, spacer, save]
        toolbar.sizeToFit()

        textField.inputView = datePicker
        textField.inputAccessoryView = toolbar
        return textField
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var iconView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        button.addTarget(self, action: #selector(datePickerClicked), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        return view
    }()

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.text = dateFormatter.string(from: self.date)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        textField.delegate = self
        return textField
    }()

    private lazy var mainView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.dateLabel,
            self.dateTextField,
            self.iconView,
        ])

        stackView.setCustomSpacing(ViewMetrics.spacing, after: dateLabel)
        stackView.setCustomSpacing(ViewMetrics.spacing, after: dateTextField)
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var onDatePickerClicked: ((Date) -> Void)?

    public var date: Date = Date() {
        didSet {
            dateLabel.text = dateFormatter.string(from: date)
        }
    }

    init(onDatePickerClicked: @escaping (Date) -> Void) {
        self.onDatePickerClicked = onDatePickerClicked
        super.init(frame: .zero)
        buildLayout()
    }

    private override init(frame: CGRect) {
        self.onDatePickerClicked = nil
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViews() {
        backgroundColor = .white
    }

    func buildViewHierarchy() {
        addSubview(mainView)
        mainView.addSubview(hiddenTextField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ViewMetrics.topMargin
            ),
            mainView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ViewMetrics.leadingMargin
            ),
            mainView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ViewMetrics.trailingMargin
            ),
            mainView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ViewMetrics.bottomMargin
            ),
        ])
    }

    @objc private func datePickerClicked() {
        hiddenTextField.becomeFirstResponder()
    }

    @objc private func dissmissDatePicker() {
        hiddenTextField.resignFirstResponder()
        datePicker.date = date
    }

    @objc private func saveDate() {
        let date = datePicker.date
        dateTextField.text = dateFormatter.string(from: date)
        hiddenTextField.resignFirstResponder()
        onDatePickerClicked?(date)
    }

    private var dateRegex = try! NSRegularExpression(pattern: "^[0-9]{0,2}/?[0-9]{0,2}/?[0-9]{0,4}$")
}

extension SearchOptionsView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let stringDate = textField.text, let date = dateFormatter.date(from: stringDate) else {
            textField.text = dateFormatter.string(from: date)
            return
        }
        textField.text = dateFormatter.string(from: date)
        onDatePickerClicked?(date)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as? NSString else { return true }
        let textAfterUpdate = currentText.replacingCharacters(in: range, with: string)
        let range = NSRange(location: 0, length: textAfterUpdate.utf16.count)
        return !dateRegex.matches(in: textAfterUpdate, options: .withoutAnchoringBounds, range: range).isEmpty
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
