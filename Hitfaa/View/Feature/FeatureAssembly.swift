//
//  FeatureAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class FeatureAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IFeatureViewModel.self, initializer: FeatureViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IFeatureService.self, initializer: FeatureService.init)
    }
}
