//
//  ProfileAssembly.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaViewModel
import HitfaaModel
import Swinject
import SwinjectAutoregistration

final class ProfileAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IProfileViewModel.self, initializer: ProfileViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IProfileService.self, initializer: ProfileService.init)
    }
}
