//
//  TabBarViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit
import Combine

class TabBarViewController:  UITabBarController {

    var viewModel: ViewModel?

    private let createdButton = ProfileView()
    private let settingsButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupUI()
        makeButtonActions()
        addTabBarShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true

        self.viewModel?.getUser()

        if let user = self.viewModel?.user {
            self.createdButton.setup(with: user.image, name: user.name)
            self.remakeProfileViewSizes()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    //MARK: Setup View Controllers
    private func setupViewControllers() {
        lazy var homeViewController = self.createNavigation(title: "Home",
                                                                 image: "home",
                                                                 vc: ViewControllerFactory.makeHomeViewController())

        lazy var diaryViewController = self.createNavigation(title: "Diary",
                                                             image: "diary",
                                                             vc: ViewControllerFactory.makeDiaryViewController())

        lazy var relaxViewController = self.createNavigation(title: "Relax",
                                                             image: "relax",
                                                             vc: ViewControllerFactory.makeRelaxViewController())

        lazy var resourcesViewController = self.createNavigation(title: "Resources",
                                                                 image: "resources",
                                                                 vc: ViewControllerFactory.makeResourcesViewController())

        lazy var checklistViewController = self.createNavigation(title: "Checklist",
                                                               image: "checklist",
                                                               vc: ViewControllerFactory.makeChecklistViewController())

        self.setViewControllers([homeViewController, diaryViewController, relaxViewController, resourcesViewController, checklistViewController], animated: true)

        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("UserInfo"), object: nil)

        homeViewController.delegate = self
        diaryViewController.delegate = self
        relaxViewController.delegate = self
        resourcesViewController.delegate = self
        checklistViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 0
    }

    @objc func setStatisticPage() {
        self.selectedIndex = 3
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .clear
        self.tabBar.isTranslucent = true

        _ = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: image)?.withTintColor(UIColor(hex: "#00A2FF")!, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = UIImage(named: image)
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor.gray
        let selectedTitleColor: UIColor = UIColor.black

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        self.tabBar.tintColor = UIColor(hex: "#00A2FF")!
        self.tabBar.unselectedItemTintColor = UIColor.gray

        return navigation
    }

    //MARK: Setup UI elements
    private func setupUI() {
        settingsButton.setImage(UIImage(named: "settingsButton"), for: .normal)

        self.view.addSubview(createdButton)
        self.view.addSubview(settingsButton)
        setupConstraints()
    }

    private func remakeProfileViewSizes() {
        createdButton.snp.remakeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(176)
            view.height.equalTo(48)
        }
    }

    private func addTabBarShadow() {
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowPath = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: tabBar.layer.cornerRadius).cgPath
    }

    private func setupConstraints() {

        createdButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(48)
        }

        settingsButton.snp.makeConstraints { view in
            view.top.equalTo(self.createdButton.snp.top).offset(8)
            view.trailing.equalTo(createdButton.snp.trailing).inset(8)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        NotificationCenter.default.removeObserver(self)
        #endif
    }
}

extension TabBarViewController: IViewModelableController {
    typealias ViewModel = ITabBarViewModel
}

//MARK: Button actions
extension TabBarViewController {
    private func makeButtonActions() {
        self.settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        self.createdButton.addTarget(self, action: #selector(createOrEditProfile), for: .touchUpInside)
    }

    @objc func createOrEditProfile() {
        guard let navigationController = self.navigationController else { return }

        TabBarRouter.showProfileViewController(in: navigationController)
    }

    @objc func settingsTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.showSettingsViewController(in: navigationController)
    }

    @objc private func handleNotification() {
        self.viewModel?.getUser()

        guard let userInfo = self.viewModel?.user else { return }

        self.createdButton.setup(with: userInfo.image, name: userInfo.name)
        remakeProfileViewSizes()
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}
