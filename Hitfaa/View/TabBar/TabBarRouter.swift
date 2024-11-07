//
//  TabBarRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class TabBarRouter: BaseRouter {

    static func showSettingsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSettingsViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showProfileViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeProfileViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
