//
//  EditRelaxAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class EditRelaxAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditRelaxViewModel.self, argument: RelaxNavigationModel.self, initializer: EditRelaxViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IRelaxService.self, initializer: RelaxService.init)
    }
}
