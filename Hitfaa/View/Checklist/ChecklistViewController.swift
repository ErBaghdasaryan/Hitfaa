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
    private let subheader = UILabel(text: "Choose where you want to direct the money that you no longer spend on betting. This will help you invest in yourself, your health and the future.",
                                    textColor: .black,
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    private let distributedMoney = StatView(title: "Money has been distributed",
                                         image: "distributedMoney")
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let count: String = self.viewModel?.appStorageService.getData(key: .distribution) {
            self.distributedMoney.setup(with: "\(count)/1300$")
        }
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        self.header.textAlignment = .left

        self.subheader.textAlignment = .left
        self.subheader.numberOfLines = 4

        self.distributedMoney.setup(with: "0/1300$")

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
        self.view.addSubview(subheader)
        self.view.addSubview(distributedMoney)
        self.view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        subheader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(88)
        }

        distributedMoney.snp.makeConstraints { view in
            view.top.equalTo(subheader.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(78)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(distributedMoney.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0    )
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(ChecklistTableViewCell.self)
    }
}

extension ChecklistViewController: IViewModelableController {
    typealias ViewModel = IChecklistViewModel
}

//MARK: Button actions
extension ChecklistViewController {
    private func makeButtonActions() {
        
    }

    private func doDistrbution(from index: Int) {
        guard let navigationController = self.navigationController else { return }

        let model = self.viewModel?.checkLists[index]

        ChecklistRouter.showMoneyCategoryViewController(in: navigationController, navigationModel: .init(model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension ChecklistViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.checkLists.count ?? 0
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChecklistTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let model = viewModel?.checkLists[indexPath.row] {
            cell.setup(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 104
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.doDistrbution(from: indexPath.row)
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
