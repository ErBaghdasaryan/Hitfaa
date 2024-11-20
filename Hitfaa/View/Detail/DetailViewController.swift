//
//  DetailViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit
import StoreKit

class DetailViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let topImage = UIImageView(image: .init(named: "main36"))
    private let bottomView = UIView()
    private let header = UILabel(text: "Be always informed",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let descriptionLabel = UILabel(text: "Don't miss anything important.",
                                           textColor: .white.withAlphaComponent(0.2),
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private let continueButton = ButtonWithImage(backgroundColor: .white,
                                                 text: "Next",
                                                 textColor: .black,
                                                 textFont: "Semibold",
                                                 imageSystemName: "chevron.right",
                                                 imageColor: .black,
                                                 imageSize: .init(width: 24,
                                                                  height: 24))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.bottomView.backgroundColor = UIColor(hex: "#00A2FF")
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2

        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        self.view.addSubview(bottomView)
        self.view.addSubview(topImage)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(266)
        }

        topImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalTo(bottomView.snp.top)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(32)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(34)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(4)
            view.trailing.equalToSuperview().inset(4)
            view.height.equalTo(44)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(64)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
            view.width.equalTo(98)
        }
    }

}

//MARK: Make buttons actions
extension DetailViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    private func setupNavigationItems() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Enabled",
                                                message: "You will now receive notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            DetailRouter.showFeatureViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    @objc func closeTapped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Disabled",
                                                message: "You will now disable notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            DetailRouter.showFeatureViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension DetailViewController: IViewModelableController {
    typealias ViewModel = IDetailViewModel
}

//MARK: Preview
import SwiftUI

struct DetailViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let detailViewController = DetailViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) -> DetailViewController {
            return detailViewController
        }

        func updateUIViewController(_ uiViewController: DetailViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) {
        }
    }
}
