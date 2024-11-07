//
//  DiaryViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class DiaryViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "My diary",
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

extension DiaryViewController: IViewModelableController {
    typealias ViewModel = IDiaryViewModel
}

//MARK: Button actions
extension DiaryViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct DiaryViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let diaryViewController = DiaryViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DiaryViewControllerProvider.ContainerView>) -> DiaryViewController {
            return diaryViewController
        }

        func updateUIViewController(_ uiViewController: DiaryViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DiaryViewControllerProvider.ContainerView>) {
        }
    }
}
