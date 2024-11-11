//
//  MotivatedView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit
import SnapKit

final class MotivatedView: UIView {

    private var frameView: UIView!
    private var titleLabel = UILabel(text: "You're still on the road to recovery",
                                     textColor: UIColor.black,
                                     font: UIFont(name: "SFProText-Bold", size: 28))
    private var messageLabel = UILabel(text: "Don't worry, setbacks happen. What's important is that you keep moving forward. Try writing down your thoughts and the reasons for the bet in your diary — it can help you understand your triggers and manage them better in the future.",
                                      textColor: UIColor.black,
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private let betField = InputField(labelText: "How much did you spend on betting?",
                                       placeholder: "Write here")
    private var dairyButton = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                               text: "Diary",
                                               textColor: .white,
                                               textFont: "Regular",
                                               imageSystemName: "book.closed.fill",
                                               imageColor: .white,
                                               imageSize: .init(width: 24, height: 24))
    private var relaxButton = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                               text: "Relax",
                                               textColor: .white,
                                               textFont: "Regular",
                                               imageSystemName: "eyebrow",
                                               imageColor: .white,
                                               imageSize: .init(width: 24, height: 24))
    private var stack: UIStackView!
    private var superViewController: UIViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
    }

    private func setupUI() {
        backgroundColor = UIColor(white: 0.0, alpha: 0.3)

        frameView = UIView()
        frameView.layer.cornerRadius = 15
        frameView.layer.masksToBounds = true
        frameView.backgroundColor = .white

        self.titleLabel.numberOfLines = 2
        self.messageLabel.numberOfLines = 7

        self.stack = UIStackView(arrangedSubviews: [dairyButton, relaxButton],
                                 axis: .horizontal,
                                 spacing: 8)

        addSubview(frameView)
        frameView.addSubview(titleLabel)
        frameView.addSubview(messageLabel)
        frameView.addSubview(betField)
        frameView.addSubview(stack)

        setupConstraints()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    private func setupConstraints() {
        frameView.snp.makeConstraints { view in
            view.center.equalToSuperview()
            view.width.equalTo(358)
            view.height.equalTo(436)
        }

        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(32)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(68)
        }

        messageLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(16)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(155)
        }

        betField.snp.makeConstraints { view in
            view.top.equalTo(messageLabel.snp.bottom).offset(16)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(62)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(betField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(32)
            view.trailing.equalToSuperview().inset(32)
            view.height.equalTo(40)
        }
    }

    private func setupActions() {
        dairyButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        relaxButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc private func dismissView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    static func show(in viewController: UIViewController) -> MotivatedView {
        let popup = MotivatedView(frame: viewController.view.bounds)
        popup.superViewController = viewController
        popup.alpha = 0.0
        viewController.view.addSubview(popup)

        UIView.animate(withDuration: 0.3) {
            popup.alpha = 1.0
        }

        return popup
    }
}

//MARK: UIGesture & cell's touches
extension MotivatedView: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.betField.textField.delegate = self

        betField.textField.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case betField.textField:
            textFieldDidEndEditing(textField)
            betField.textField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
    }

    private func checkAllFields() -> Bool {
        guard let bet = self.betField.textField.text else { return true }

        return bet.isEmpty
    }

    @objc private func hideKeyboard() {
        self.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
}
