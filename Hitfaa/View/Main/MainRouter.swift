//
//  MainRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import UIKit
import HitfaaViewModel

final class MainRouter: BaseRouter {
    static func showDetailViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeDetailViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
