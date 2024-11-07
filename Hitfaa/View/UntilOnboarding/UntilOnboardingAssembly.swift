//
//  UntilOnboardingAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class UntilOnboardingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IUntilOnboardingViewModel.self, initializer: UntilOnboardingViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IUntilOnboardingService.self, initializer: UntilOnboardingService.init)
    }
}
