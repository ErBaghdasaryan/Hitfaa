//
//  EditResourceAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class EditResourceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditResourcesViewModel.self, argument: ResourceNavigationModel.self, initializer: EditResourcesViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IResourcesService.self, initializer: ResourcesService.init)
    }
}
