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
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        self.header.textAlignment = .left

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
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

        tableView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0    )
    }

    override func setupViewModel() {
        super.setupViewModel()
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadData()
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(AddRelaxTableViewCell.self)
        self.tableView.register(RelaxTableViewCell.self)
    }
}

extension RelaxViewController: IViewModelableController {
    typealias ViewModel = IRelaxViewModel
}

//MARK: Button actions
extension RelaxViewController {
    private func makeButtonActions() {
        
    }

    private func addRelax() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        RelaxRouter.showAddRelaxViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    private func editRelax(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.relaxes[index - 1]

        RelaxRouter.showEditRelaxViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension RelaxViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.relaxes.count ?? 0
        return count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: AddRelaxTableViewCell = tableView.dequeueReusableCell(for: indexPath)

            cell.setup(with: "Add new story")
            return cell
        } else {
            let cell: RelaxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.relaxes[indexPath.row - 1] {
                cell.setup(model: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 72
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            self.addRelax()
        } else {
            self.editRelax(for: indexPath.row)
        }
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
