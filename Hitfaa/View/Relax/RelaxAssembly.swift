//
//  RelaxAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class RelaxAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IRelaxViewModel.self, initializer: RelaxViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IRelaxService.self, initializer: RelaxService.init)
    }
}
