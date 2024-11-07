//
//  ResourcesAsssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel
import HitfaaViewModel
import Swinject
import SwinjectAutoregistration

final class ResourcesAsssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IResourcesViewModel.self, initializer: ResourcesViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IResourcesService.self, initializer: ResourcesService.init)
    }
}
