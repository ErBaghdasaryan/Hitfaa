//
//  SettingsViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit
import StoreKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Settings",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 28))

    private let share = SettingsView(title: "Share the app",
                                     image: "share")
    private let rate = SettingsView(title: "Rate the app",
                                    image: "rate")
    private let usage = SettingsView(title: "Usage Policy",
                                     image: "usage")

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)
        self.header.textAlignment = .left

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(share)
        self.view.addSubview(rate)
        self.view.addSubview(usage)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
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

        share.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }

        rate.snp.makeConstraints { view in
            view.top.equalTo(share.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }

        usage.snp.makeConstraints { view in
            view.top.equalTo(rate.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }
    }
}


extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Progress View
extension SettingsViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        rate.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        usage.addTarget(self, action: #selector(usageTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.popViewController(in: navigationController)
    }

    @objc func shareTapped() {
        let appStoreURL = URL(string: "https://apps.apple.com/us/app/game-help-with-addiction/id6738176731")!

        let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .openInIBooks,
            .markupAsPDF
        ]

        present(activityViewController, animated: true, completion: nil)
    }

    @objc func rateTapped() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/game-help-with-addiction/id6738176731") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc func usageTapped() {
        guard let navigationController = self.navigationController else { return }
        SettingsRouter.showUsageViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
