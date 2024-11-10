//
//  EditResourceViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class EditResourceViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let text = TextView(placeholder: "Write here")

    private let close = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                         text: "Close",
                                         textColor: .white,
                                         textFont: "Regular",
                                         imageSystemName: "xmark.circle.fill",
                                         imageColor: .white,
                                         imageSize: .init(width: 24, height: 24))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let model = self.viewModel?.resource else { return }

        self.header.text = model.header
        self.text.text = model.text
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.header.textAlignment = .left
        self.header.numberOfLines = 4

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(text)
        self.view.addSubview(close)
        setupConstraints()
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
            view.height.equalTo(105)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(176)
        }

        close.snp.makeConstraints { view in
            view.top.equalTo(text.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }
    }
}


extension EditResourceViewController: IViewModelableController {
    typealias ViewModel = IEditResourcesViewModel
}

//MARK: Progress View
extension EditResourceViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        close.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        ResourcesRouter.popViewController(in: navigationController)
    }
}

//MARK: UIGesture & cell's touches
extension EditResourceViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: Preview
import SwiftUI

struct EditResourceViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editResourceViewController = EditResourceViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditResourceViewControllerProvider.ContainerView>) -> EditResourceViewController {
            return editResourceViewController
        }

        func updateUIViewController(_ uiViewController: EditResourceViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditResourceViewControllerProvider.ContainerView>) {
        }
    }
}
