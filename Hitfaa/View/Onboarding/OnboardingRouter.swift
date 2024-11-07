//
//  AssemblyRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import UIKit
import HitfaaViewModel

final class OnboardingRouter: BaseRouter {
    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
