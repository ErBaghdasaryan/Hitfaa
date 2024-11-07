//
//  ChecklistViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class ChecklistViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Checklist",
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

extension ChecklistViewController: IViewModelableController {
    typealias ViewModel = IChecklistViewModel
}

//MARK: Button actions
extension ChecklistViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct ChecklistViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let checklistViewController = ChecklistViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChecklistViewControllerProvider.ContainerView>) -> ChecklistViewController {
            return checklistViewController
        }

        func updateUIViewController(_ uiViewController: ChecklistViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChecklistViewControllerProvider.ContainerView>) {
        }
    }
}
