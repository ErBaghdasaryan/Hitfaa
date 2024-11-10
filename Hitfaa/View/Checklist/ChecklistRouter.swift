//
//  ChecklistRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class ChecklistRouter: BaseRouter {

    static func showMoneyCategoryViewController(in navigationController: UINavigationController, navigationModel: CheckListNavigationModel) {
        let viewController = ViewControllerFactory.makeMoneyCategoryViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
