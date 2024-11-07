//
//  BaseRouter.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import Combine
import HitfaaViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
