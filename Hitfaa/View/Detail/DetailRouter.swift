//
//  DetailRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import UIKit
import HitfaaViewModel

final class DetailRouter: BaseRouter {
    static func showFeatureViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFeatureViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
