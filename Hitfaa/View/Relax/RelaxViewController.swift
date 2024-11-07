//
//  RelaxViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class RelaxViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Meditation & relax",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        self.header.textAlignment = .left

        self.view.addSubview(header)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
    }
}

extension RelaxViewController: IViewModelableController {
    typealias ViewModel = IRelaxViewModel
}

//MARK: Button actions
extension RelaxViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct RelaxViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let relaxViewController = RelaxViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<RelaxViewControllerProvider.ContainerView>) -> RelaxViewController {
            return relaxViewController
        }

        func updateUIViewController(_ uiViewController: RelaxViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<RelaxViewControllerProvider.ContainerView>) {
        }
    }
}
