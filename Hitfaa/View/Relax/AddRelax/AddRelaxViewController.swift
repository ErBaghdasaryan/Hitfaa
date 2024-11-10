//
//  AddRelaxViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class AddRelaxViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = HeaderField(placeholder: "New entry")
    private let text = TextView(placeholder: "Write here")

    private let onHold = ButtonWithImage(backgroundColor: UIColor(hex: "#084176")!,
                                         text: "On hold",
                                         textColor: .white,
                                         textFont: "Regular",
                                         imageSystemName: "onhold",
                                         imageColor: .white,
                                         imageSize: .init(width: 24, height: 24),
                                         isSystem: false)
    private let compete = ButtonWithImage(backgroundColor: UIColor(hex: "#40D665")!,
                                         text: "Compete",
                                         textColor: .white,
                                         textFont: "Regular",
                                         imageSystemName: "like",
                                         imageColor: .white,
                                         imageSize: .init(width: 24, height: 24),
                                         isSystem: false)
    private var buttonsStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.header.textAlignment = .left

        self.buttonsStack = UIStackView(arrangedSubviews: [onHold, compete],
                                        axis: .horizontal,
                                        spacing: 8)

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(text)
        self.view.addSubview(buttonsStack)
        setupConstraints()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(138)
            view.leading.equalToSuperview().offset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(138)
            view.leading.equalTo(backButton.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(176)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(text.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }
    }
}


extension AddRelaxViewController: IViewModelableController {
    typealias ViewModel = IAddRelaxViewModel
}

//MARK: Progress View
extension AddRelaxViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        onHold.addTarget(self, action: #selector(saveDairy(_:)), for: .touchUpInside)
        compete.addTarget(self, action: #selector(saveDairy(_:)), for: .touchUpInside)
    }

    @objc func saveDairy(_ sender: UIButton) {
        guard let navigationController = self.navigationController else { return }
        guard let title = self.header.text else { return }
        guard let text = self.text.text else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMMM yyyy"

        let todayDate = Date()
        let formattedDate = dateFormatter.string(from: todayDate)

        switch sender {
        case self.onHold:
            self.viewModel?.addRelax(model: .init(title: title,
                                                  text: text,
                                                  year: formattedDate,
                                                  state: "onhold"))
        case self.compete:
            self.viewModel?.addRelax(model: .init(title: title,
                                                  text: text,
                                                  year: formattedDate,
                                                  state: "compete"))
        default:
            break
        }

        DiaryRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        DiaryRouter.popViewController(in: navigationController)
    }
}

//MARK: UIGesture & cell's touches
extension AddRelaxViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.header.delegate = self
        self.text.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.header:
            textFieldDidEndEditing(textField)
            self.text.becomeFirstResponder()
        case self.text:
            textFieldDidEndEditing(textField)
            self.text.resignFirstResponder()
        default:
            break
        }
        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        text.placeholderLabel.isHidden = !text.text.isEmpty
        updateButtonBackgroundColor()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
        let firstbuttonColor = allFieldsFilled ? UIColor(hex: "#084176") : UIColor(hex: "#084176")!.withAlphaComponent(0.5)
        let secondbuttonColor = allFieldsFilled ? UIColor(hex: "#40D665") : UIColor(hex: "#40D665")!.withAlphaComponent(0.5)
        self.onHold.backgroundColor = firstbuttonColor
        self.compete.backgroundColor = secondbuttonColor
        self.onHold.isUserInteractionEnabled = allFieldsFilled ? true : false
        self.compete.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let header = self.header.text else { return true }
        guard let text = self.text.text else { return true }

        return header.isEmpty || text.isEmpty
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Preview
import SwiftUI

struct AddRelaxViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addRelaxViewController = AddRelaxViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddRelaxViewControllerProvider.ContainerView>) -> AddRelaxViewController {
            return addRelaxViewController
        }

        func updateUIViewController(_ uiViewController: AddRelaxViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddRelaxViewControllerProvider.ContainerView>) {
        }
    }
}
