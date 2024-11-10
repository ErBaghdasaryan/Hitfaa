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

        self.tableView.register(AddDairyTableViewCell.self)
        self.tableView.register(DiaryTableViewCell.self)
    }
}

extension DiaryViewController: IViewModelableController {
    typealias ViewModel = IDiaryViewModel
}

//MARK: Button actions
extension DiaryViewController {
    private func makeButtonActions() {
        
    }

    private func addDairy() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        DiaryRouter.showAddDairyViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    private func editDairy(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.diaries[index - 1]

        DiaryRouter.showEditDairyViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension DiaryViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.diaries.count ?? 0
        return count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: AddDairyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = "d MMMM yyyy"
            
            let todayDate = Date()
            let formattedDate = dateFormatter.string(from: todayDate)
            
            cell.setup(model: .init(title: "Add new entry", text: "", year: formattedDate))
            return cell
        } else {
            let cell: DiaryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.diaries[indexPath.row - 1] {
                cell.setup(model: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 82
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            self.addDairy()
        } else {
            self.editDairy(for: indexPath.row)
        }
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
