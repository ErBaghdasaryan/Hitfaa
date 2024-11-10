//
//  MoneyCategoryAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class MoneyCategoryAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IMoneyCategoryViewModel.self, argument: CheckListNavigationModel.self, initializer: MoneyCategoryViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IChecklistService.self, initializer: ChecklistService.init)
    }
}
