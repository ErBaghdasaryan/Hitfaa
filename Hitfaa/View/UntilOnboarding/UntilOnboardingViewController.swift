//
//  UntilOnboardingViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class UntilOnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let logoImage = UIImageView(image: .init(named: "appLogo"))
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#084176")

        activityIndicator.color = .gray
        activityIndicator.startAnimating()

        self.view.addSubview(logoImage)
        self.view.addSubview(activityIndicator)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

        logoImage.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.equalTo(200)
            view.width.equalTo(200)
        }

        activityIndicator.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.bottom.equalToSuperview().inset(101)
        }
    }
}


extension UntilOnboardingViewController: IViewModelableController {
    typealias ViewModel = IUntilOnboardingViewModel
}

//MARK: Progress View
extension UntilOnboardingViewController {
    private func startLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.goToNextPage()
        }
    }

    private func goToNextPage() {
        guard let navigationController = self.navigationController else { return }
        guard var viewModel = self.viewModel else { return }
        if viewModel.appStorageService.hasData(for: .skipOnboarding) {
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
            //showTabBar
        } else {
            viewModel.skipOnboarding = true
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
        }
    }
}

//MARK: Preview
import SwiftUI

struct UntilOnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let untilOnboardingViewController = UntilOnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) -> UntilOnboardingViewController {
            return untilOnboardingViewController
        }

        func updateUIViewController(_ uiViewController: UntilOnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) {
        }
    }
}

