//
//  ResourcesViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class ResourcesViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Resources",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let articles = UIButton(type: .system)
    private let recommented = UIButton(type: .system)
    private let researche = UIButton(type: .system)
    private var buttonsStack: UIStackView!

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

        self.articles.setTitle("Articles", for: .normal)
        self.articles.setTitleColor(.black, for: .normal)
        self.articles.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.articles.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.articles.layer.masksToBounds = true
        self.articles.layer.cornerRadius = 5

        self.recommented.setTitle("Recommented", for: .normal)
        self.recommented.setTitleColor(.gray, for: .normal)
        self.recommented.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.recommented.backgroundColor = .white
        self.recommented.layer.masksToBounds = true
        self.recommented.layer.cornerRadius = 5

        self.researche.setTitle("Research", for: .normal)
        self.researche.setTitleColor(.gray, for: .normal)
        self.researche.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.researche.backgroundColor = .white
        self.researche.layer.masksToBounds = true
        self.researche.layer.cornerRadius = 5

        self.buttonsStack = UIStackView(arrangedSubviews: [articles, recommented, researche],
                                        axis: .horizontal,
                                        spacing: 0)

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
        self.view.addSubview(buttonsStack)
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

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(buttonsStack.snp.bottom).offset(16)
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

        self.tableView.register(ResourcesTableViewCell.self)

    }
}

extension ResourcesViewController: IViewModelableController {
    typealias ViewModel = IResourcesViewModel
}

//MARK: Button actions
extension ResourcesViewController {
    private func makeButtonActions() {
        articles.addTarget(self, action: #selector(reloadWithNewData(_:)), for: .touchUpInside)
        recommented.addTarget(self, action: #selector(reloadWithNewData(_:)), for: .touchUpInside)
        researche.addTarget(self, action: #selector(reloadWithNewData(_:)), for: .touchUpInside)
    }

    private func seeResource(for index: Int) {
        guard let navigationController = self.navigationController else { return }

        let model = self.viewModel?.selectedResources[index]

        ResourcesRouter.showEditResourceViewController(in: navigationController, navigationModel: .init(model: model!))
    }

    @objc func reloadWithNewData(_ sender: UIButton) {

        if sender == articles {
            self.articles.setTitleColor(.black, for: .normal)
            self.articles.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

            if let articules = self.viewModel?.articuleResources {
                self.viewModel?.selectedResources = articules
                self.tableView.reloadData()
            }

            self.recommented.setTitleColor(.gray, for: .normal)
            self.recommented.backgroundColor = .white
            self.researche.setTitleColor(.gray, for: .normal)
            self.researche.backgroundColor = .white
        } else if sender == recommented {
            self.recommented.setTitleColor(.black, for: .normal)
            self.recommented.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

            if let recommented = self.viewModel?.recomendedResources {
                self.viewModel?.selectedResources = recommented
                self.tableView.reloadData()
            }

            self.articles.setTitleColor(.gray, for: .normal)
            self.articles.backgroundColor = .white
            self.researche.setTitleColor(.gray, for: .normal)
            self.researche.backgroundColor = .white
        } else if sender == researche {
            self.researche.setTitleColor(.black, for: .normal)
            self.researche.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

            if let research = self.viewModel?.researchedResources {
                self.viewModel?.selectedResources = research
                self.tableView.reloadData()
            }

            self.recommented.setTitleColor(.gray, for: .normal)
            self.recommented.backgroundColor = .white
            self.articles.setTitleColor(.gray, for: .normal)
            self.articles.backgroundColor = .white
        }
    }
}

//MARK: TableView Delegate & Data source
extension ResourcesViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.selectedResources.count ?? 0
        return count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResourcesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let model = viewModel?.selectedResources[indexPath.row] {
            cell.setup(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 104
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.seeResource(for: indexPath.row)
    }
}

//MARK: Preview
import SwiftUI

struct ResourcesViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let resourcesViewController = ResourcesViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ResourcesViewControllerProvider.ContainerView>) -> ResourcesViewController {
            return resourcesViewController
        }

        func updateUIViewController(_ uiViewController: ResourcesViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ResourcesViewControllerProvider.ContainerView>) {
        }
    }
}
