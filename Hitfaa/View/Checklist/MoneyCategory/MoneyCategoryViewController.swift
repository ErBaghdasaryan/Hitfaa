//
//  MoneyCategoryViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class MoneyCategoryViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Distribute money to categories",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let canDistribute = UILabel(text: "You can distribute 1300$",
                                        textColor: .black,
                                        font: UIFont(name: "SFProText-Semibold", size: 17))
    private let distributionView = DistributionView()
    private let toCategories = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                         text: "Distribute to categories",
                                         textColor: .white,
                                         textFont: "Regular",
                                         imageSystemName: "chevron.right",
                                         imageColor: .white,
                                         imageSize: .init(width: 24, height: 24))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.checkList else { return }

        if let count: String = self.viewModel?.appStorageService.getData(key: .distribution) {
            let calculatedValue = 1300 - Int(count)!
            self.canDistribute.text = "You can distribute \(calculatedValue)$"
        }

        self.distributionView.setup(model: model)
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.header.textAlignment = .left
        self.header.numberOfLines = 2

        self.canDistribute.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.canDistribute.layer.masksToBounds = true
        self.canDistribute.layer.cornerRadius = 6

        self.distributionView.subheader.backgroundColor = .clear

        updateButtonBackgroundColor()

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(canDistribute)
        self.view.addSubview(distributionView)
        self.view.addSubview(toCategories)
        setupConstraints()
        setupViewTapHandling()
        setupTextFieldDelegates()
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
            view.height.equalTo(68)
        }

        canDistribute.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }

        distributionView.snp.makeConstraints { view in
            view.top.equalTo(canDistribute.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(92)
        }

        toCategories.snp.makeConstraints { view in
            view.top.equalTo(distributionView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }
    }
}


extension MoneyCategoryViewController: IViewModelableController {
    typealias ViewModel = IMoneyCategoryViewModel
}

//MARK: Progress View
extension MoneyCategoryViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        toCategories.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }

    @objc func calculate() {
        guard let navigationController = self.navigationController else { return }
        guard let count = self.distributionView.subheader.text else { return }
        self.viewModel?.appStorageService.saveData(key: .distribution, value: "\(count)")
        let intCount = Int(count)!
        if let count: String = self.viewModel?.appStorageService.getData(key: .distribution) {
            let calculatedValue = intCount + (Int(count) ?? 0)
            self.viewModel?.appStorageService.saveData(key: .distribution, value: "\(calculatedValue)")
        }
        ChecklistRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        ChecklistRouter.popViewController(in: navigationController)
    }
}

//MARK: UIGesture & cell's touches
extension MoneyCategoryViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.distributionView.subheader.delegate = self

        self.distributionView.subheader.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.distributionView.subheader:
            textFieldDidEndEditing(textField)
            self.distributionView.subheader.resignFirstResponder()
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
        let buttonColor = allFieldsFilled ? UIColor(hex: "#00A2FF") : UIColor(hex: "#00A2FF")!.withAlphaComponent(0.5)
        self.toCategories.backgroundColor = buttonColor
        self.toCategories.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let moneyPrice = self.distributionView.subheader.text else { return true }

        return moneyPrice.isEmpty
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

struct MoneyCategoryViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let moneyCategoryViewController = MoneyCategoryViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MoneyCategoryViewControllerProvider.ContainerView>) -> MoneyCategoryViewController {
            return moneyCategoryViewController
        }

        func updateUIViewController(_ uiViewController: MoneyCategoryViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MoneyCategoryViewControllerProvider.ContainerView>) {
        }
    }
}
