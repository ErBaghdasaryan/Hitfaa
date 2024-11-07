//
//  ProfileViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit
import StoreKit

class ProfileViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Your profile",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let nameField = InputField(labelText: "Your name",
                                       placeholder: "Write here")
    private let betField = InputField(labelText: "Spending on bets per month",
                                      placeholder: "Write here")

    private let defaultImage = AddPhotoView()
    private let addImage = UIButton(type: .system)
    private var selectedImage: UIImage?

    private let dateOf = UILabel(text: "Date of registration",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 22))
    private let dateLabel = UILabel(text: "10 october 2024",
                                    textColor: .black,
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    private let howDays = UILabel(text: "0 days in app",
                                  textColor: .gray.withAlphaComponent(0.2),
                                    font: UIFont(name: "SFProText-Semibold", size: 12))

    private let setReminders = UILabel(text: "Set reminders",
                                       textColor: .black,
                                       font: UIFont(name: "SFProText-Bold", size: 22))
    private let reminderText = UILabel(text: "Set reminders so that you do not forget that you are going to the goal. Set a reminder for every",
                                       textColor: .black,
                                       font: UIFont(name: "SFProText-Regular", size: 17))

    private let firstButton = UIButton(type: .system)
    private let secondButton = UIButton(type: .system)
    private let thirdButton = UIButton(type: .system)
    private var buttonsStack: UIStackView!

    private var isFirstTime: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = self.viewModel?.user else { return }

        self.defaultImage.setup(with: user.image)
        self.selectedImage = user.image
        self.nameField.textField.text = user.name
        self.betField.textField.text = user.moneyAmount
        self.dateLabel.text = user.year
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.header.textAlignment = .left

        self.dateOf.textAlignment = .left
        self.dateLabel.textAlignment = .left
        self.howDays.textAlignment = .left
        self.setReminders.textAlignment = .left

        self.reminderText.numberOfLines = 3
        self.reminderText.textAlignment = .left

        self.firstButton.setTitle("1 hour", for: .normal)
        self.firstButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.firstButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
        self.firstButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.firstButton.layer.cornerRadius = 7
        self.firstButton.layer.masksToBounds = true

        self.secondButton.setTitle("2 hour", for: .normal)
        self.secondButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.secondButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
        self.secondButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.secondButton.layer.cornerRadius = 7
        self.secondButton.layer.masksToBounds = true

        self.thirdButton.setTitle("3 hour", for: .normal)
        self.thirdButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.thirdButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
        self.thirdButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.thirdButton.layer.cornerRadius = 7
        self.thirdButton.layer.masksToBounds = true

        self.buttonsStack = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton],
                                        axis: .horizontal,
                                        spacing: 8)

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(nameField)
        self.view.addSubview(betField)
        self.view.addSubview(dateOf)
        self.view.addSubview(dateLabel)
        self.view.addSubview(howDays)
        self.view.addSubview(setReminders)
        self.view.addSubview(reminderText)
        self.view.addSubview(buttonsStack)
        setupConstraints()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.getUser()

        if let user = self.viewModel?.user {
            self.isFirstTime = false
        } else {
            self.isFirstTime = true
        }
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(86)
            view.leading.equalToSuperview().offset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(86)
            view.leading.equalTo(backButton.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        addImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        nameField.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalTo(defaultImage.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(62)
        }

        betField.snp.makeConstraints { view in
            view.top.equalTo(nameField.snp.bottom).offset(16)
            view.leading.equalTo(defaultImage.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(62)
        }

        dateOf.snp.makeConstraints { view in
            view.top.equalTo(betField.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        dateLabel.snp.makeConstraints { view in
            view.top.equalTo(dateOf.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        howDays.snp.makeConstraints { view in
            view.top.equalTo(dateLabel.snp.bottom).offset(4)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
        }

        setReminders.snp.makeConstraints { view in
            view.top.equalTo(howDays.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        reminderText.snp.makeConstraints { view in
            view.top.equalTo(setReminders.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(70)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(reminderText.snp.bottom).offset(11)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }
    }
}


extension ProfileViewController: IViewModelableController {
    typealias ViewModel = IProfileViewModel
}

//MARK: Progress View
extension ProfileViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        firstButton.addTarget(self, action: #selector(reminderButtonTapped(_:)), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(reminderButtonTapped(_:)), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(reminderButtonTapped(_:)), for: .touchUpInside)
    }

    @objc func reminderButtonTapped(_ sender: UIButton) {

        if sender == firstButton {
            self.firstButton.backgroundColor = UIColor(hex: "#00A2FF")
            self.firstButton.setTitleColor(.white, for: .normal)

            self.secondButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.secondButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
            self.thirdButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.thirdButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        } else if sender == secondButton {
            self.secondButton.backgroundColor = UIColor(hex: "#00A2FF")
            self.secondButton.setTitleColor(.white, for: .normal)

            self.firstButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.firstButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
            self.thirdButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.thirdButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        } else if sender == thirdButton {
            self.thirdButton.backgroundColor = UIColor(hex: "#00A2FF")
            self.thirdButton.setTitleColor(.white, for: .normal)

            self.firstButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.firstButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
            self.secondButton.setTitleColor(.gray.withAlphaComponent(0.2), for: .normal)
            self.secondButton.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        }
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        guard let image = self.selectedImage else { 
            TabBarRouter.popViewController(in: navigationController)
            return
        }
        guard let name = self.nameField.textField.text else {
            TabBarRouter.popViewController(in: navigationController)
            return
        }
        guard let bet = self.betField.textField.text else { 
            TabBarRouter.popViewController(in: navigationController)
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMMM yyyy"

        let todayDate = Date()
        let formattedDate = dateFormatter.string(from: todayDate)

        if self.isFirstTime {
            self.viewModel?.addUser(model: .init(image: image,
                                                 name: name,
                                                 moneyAmount: bet,
                                                 year: formattedDate))
        } else {
            self.viewModel?.updateUser(model: .init(image: image,
                                                    name: name,
                                                    moneyAmount: bet,
                                                    year: formattedDate))
        }

        NotificationCenter.default.post(name: Notification.Name("UserInfo"), object: nil, userInfo: nil)
        TabBarRouter.popViewController(in: navigationController)
    }

    @objc func addImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
}

//MARK: Image Picker
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: UIGesture & cell's touches
extension ProfileViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.nameField.textField.delegate = self
        self.betField.textField.delegate = self

        betField.textField.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField.textField:
            textFieldDidEndEditing(textField)
            self.betField.textField.becomeFirstResponder()
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
        guard let name = self.nameField.textField.text else { return true }
        guard let bet = self.betField.textField.text else { return true }

        return name.isEmpty || bet.isEmpty
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

struct ProfileViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let profileViewController = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) -> ProfileViewController {
            return profileViewController
        }

        func updateUIViewController(_ uiViewController: ProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) {
        }
    }
}
