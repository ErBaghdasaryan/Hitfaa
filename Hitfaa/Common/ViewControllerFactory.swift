//
//  ViewControllerFactory.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import Swinject
import HitfaaViewModel
import HitfaaModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]
    
    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let assembler = Assembler(commonAssemblies + [TabBarAssembly()])
        let viewController = TabBarViewController()
        viewController.viewModel = assembler.resolver.resolve(ITabBarViewModel.self)
        return viewController
    }

    //MARK: - Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: - Profile
    static func makeProfileViewController() -> ProfileViewController {
        let assembler = Assembler(commonAssemblies + [ProfileAssembly()])
        let viewController = ProfileViewController()
        viewController.viewModel = assembler.resolver.resolve(IProfileViewModel.self)
        return viewController
    }

    //MARK: - Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: - Diary
    static func makeDiaryViewController() -> DiaryViewController {
        let assembler = Assembler(commonAssemblies + [DiaryAssembly()])
        let viewController = DiaryViewController()
        viewController.viewModel = assembler.resolver.resolve(IDiaryViewModel.self)
        return viewController
    }

    //MARK: - Relax
    static func makeRelaxViewController() -> RelaxViewController {
        let assembler = Assembler(commonAssemblies + [RelaxAssembly()])
        let viewController = RelaxViewController()
        viewController.viewModel = assembler.resolver.resolve(IRelaxViewModel.self)
        return viewController
    }

    //MARK: - Resources
    static func makeResourcesViewController() -> ResourcesViewController {
        let assembler = Assembler(commonAssemblies + [ResourcesAsssembly()])
        let viewController = ResourcesViewController()
        viewController.viewModel = assembler.resolver.resolve(IResourcesViewModel.self)
        return viewController
    }

    //MARK: - Checklist
    static func makeChecklistViewController() -> ChecklistViewController {
        let assembler = Assembler(commonAssemblies + [ChecklistAssembly()])
        let viewController = ChecklistViewController()
        viewController.viewModel = assembler.resolver.resolve(IChecklistViewModel.self)
        return viewController
    }
}
