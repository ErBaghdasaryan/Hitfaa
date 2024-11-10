//
//  CongratsView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

//import UIKit
//import SnapKit
//import HitfaaModel
//
//final class CongratsView: UIView {
//
//    private var frameView: UIView!
//    private var titleLabel: UILabel!
//
//    private var saveButton: UIButton!
//    private var superViewController: UIViewController!
//
//    var delegate: (_ model: EntryModel, _ category: CategoryModel) -> Void = { _ , _  in }
//
//    var title: String {
//        get {
//            titleLabel.text ?? ""
//        }
//        set {
//            titleLabel.text = newValue
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        makeButtonActions()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//        makeButtonActions()
//    }
//
//    private func setupUI() {
//        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
//
//        frameView = UIView()
//        frameView.layer.cornerRadius = 20
//        frameView.layer.masksToBounds = true
//        frameView.backgroundColor = .white
//        շ
//
//        titleLabel = UILabel()
//        titleLabel.font = UIFont(name: "SFProText-Semibold", size: 17)
//        titleLabel.textColor = .black
//        titleLabel.textAlignment = .center
//
//        saveButton = UIButton()
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.layer.cornerRadius = 12
//        saveButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
//        saveButton.setTitleColor(.white, for: .normal)
//        saveButton.backgroundColor = UIColor(hex: "#3B3C3D")
//
//        incomeLabel = UILabel(text: "Income",
//                              textColor: .black,
//                              font: UIFont(name: "SFProText-Semibold", size: 17))
//
//        addSubview(frameView)
//        frameView.addSubview(titleLabel)
//        frameView.addSubview(saveButton)
//
//        setupConstraints()
//        setupViewTapHandling()
//        setupTextFieldDelegates()
//    }
//
//    private func setupConstraints() {
//        frameView.snp.makeConstraints { view in
//            view.bottom.equalToSuperview()
//            view.leading.equalToSuperview()
//            view.trailing.equalToSuperview()
//            view.height.equalTo(442)
//        }
//
//        titleLabel.snp.makeConstraints { view in
//            view.top.equalToSuperview().offset(20)
//            view.leading.equalToSuperview().offset(20)
//            view.trailing.equalToSuperview().offset(-20)
//        }
//
//        nameField.snp.makeConstraints { view in
//            view.top.equalTo(titleLabel.snp.bottom).offset(20)
//            view.leading.equalToSuperview().offset(15)
//            view.trailing.equalToSuperview().inset(15)
//            view.height.equalTo(54)
//        }
//
//        collectionView.snp.makeConstraints { view in
//            view.top.equalTo(nameField.snp.bottom).offset(8)
//            view.leading.equalToSuperview().offset(15)
//            view.trailing.equalToSuperview().inset(15)
//            view.height.equalTo(40)
//        }
//
//        moneyField.snp.makeConstraints { view in
//            view.top.equalTo(nameField.snp.bottom).offset(56)
//            view.leading.equalToSuperview().offset(15)
//            view.trailing.equalToSuperview().inset(15)
//            view.height.equalTo(54)
//        }
//
//        switchControl.snp.makeConstraints { view in
//            view.top.equalTo(moneyField.snp.bottom).offset(8)
//            view.leading.equalToSuperview().inset(15)
//            view.width.equalTo(51)
//            view.height.equalTo(31)
//        }
//
//        incomeLabel.snp.makeConstraints { view in
//            view.centerY.equalTo(switchControl.snp.centerY)
//            view.leading.equalTo(switchControl.snp.trailing).offset(8)
//            view.width.equalTo(65)
//            view.height.equalTo(21)
//        }
//
//        saveButton.snp.makeConstraints { view in
//            view.top.equalTo(switchControl.snp.bottom).offset(16)
//            view.leading.equalToSuperview().offset(15)
//            view.trailing.equalToSuperview().inset(15)
//            view.height.equalTo(54)
//        }
//    }
//}
//
//
//extension CongratsView {
//    private func makeButtonActions() {
//        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
//        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
//    }
//
//    @objc func switchValueChanged(_ sender: UISwitch) {
//        if sender.isOn {
//            self.toggleStatus = true
//        } else {
//            self.toggleStatus = false
//        }
//    }
//
//    @objc func savePressed() {
//        guard let name = nameField.text else { return }
//        guard let selectedItem = self.selectedItem else { return }
//        guard let money = moneyField.text else { return }
//        let category = self.tagArray[selectedItem - 1]
//
//        let model = EntryModel(categoryId: category.id ?? 1,
//                               categoryName: category.title,
//                               name: name,
//                               budget: money,
//                               isIncome: self.toggleStatus)
//        disappearAndReturn(model: model)
//    }
//
//    @objc func addCategories() {
//        showAlertWithTextField(
//            title: "Add a category",
//            placeholder: "Category name",
//            defaultText: "",
//            saveAction: { enteredText in
//                self.tagArray.append(.init(title: enteredText))
//                self.collectionView.reloadData()
//            }
//        )
//    }
//
//    private func showAlertWithTextField(title: String, placeholder: String, defaultText: String? = nil, saveAction: @escaping (String) -> Void) {
//        let alertController = UIAlertController(title: title, message: "The category will not be saved if an entry is not assigned to it", preferredStyle: .alert)
//
//        alertController.addTextField { textField in
//            textField.placeholder = placeholder
//            textField.text = defaultText
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        let saveActionButton = UIAlertAction(title: "Save", style: .destructive) { _ in
//            if let textField = alertController.textFields?.first {
//                let enteredText = textField.text ?? ""
//                saveAction(enteredText)
//            }
//        }
//        alertController.addAction(saveActionButton)
//
//        self.superViewController.present(alertController, animated: true, completion: nil)
//    }
//
//    private func disappearAndReturn(model: EntryModel) {
//        guard let itemIndex = self.selectedItem else { return }
//        let categoryModel = self.tagArray[itemIndex - 1]
//        UIView.animate(withDuration: 0.3) {
//            self.alpha = 0.0
//        } completion: { (_) in
//            self.removeFromSuperview()
//            self.delegate(model, categoryModel)
//        }
//    }
//
//    static func createAndShow(in viewController: UIViewController, title: String, tags: [CategoryModel], delegate: @escaping (_ model: EntryModel, _ category: CategoryModel) -> Void) -> AddEntryView {
//        let popup = AddEntryView(frame: viewController.view.bounds)
//        popup.title = title
//        popup.tagArray = tags
//        popup.delegate = delegate
//        popup.superViewController = viewController
//        popup.alpha = 0.0
//        viewController.view.addSubview(popup)
//
//        UIView.animate(withDuration: 0.3) {
//            popup.alpha = 1.0
//        }
//
//        return popup
//    }
//}

