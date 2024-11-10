//
//  ResourcesRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class ResourcesRouter: BaseRouter {

    static func showEditResourceViewController(in navigationController: UINavigationController, navigationModel: ResourceNavigationModel) {
        let viewController = ViewControllerFactory.makeEditResourseViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
