//
//  FeatureViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import WebKit
import SnapKit
import HitfaaViewModel

final class FeatureViewController: BaseViewController {
    var viewModel: ViewModel?

    private let webView = WKWebView()
    private var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.webView.backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {
        guard let viewModel = self.viewModel else { return }
        self.url = viewModel.url
        if let url = URL(string: self.url) {
            webView.load(URLRequest(url: url))
        }
    }
}

extension FeatureViewController: IViewModelableController {
    typealias ViewModel = IFeatureViewModel
}

import SwiftUI

struct FeatureViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let featureViewController = FeatureViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<FeatureViewControllerProvider.ContainerView>) -> FeatureViewController {
            return featureViewController
        }

        func updateUIViewController(_ uiViewController: FeatureViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FeatureViewControllerProvider.ContainerView>) {
        }
    }
}
