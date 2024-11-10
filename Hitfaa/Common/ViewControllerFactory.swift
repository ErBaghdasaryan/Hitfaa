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

    static func makeEditDairyViewController(navigationModel: DairyNavigationModel) -> EditDairyViewController {
        let assembler = Assembler(commonAssemblies + [EditDairyAssembly()])
        let viewController = EditDairyViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditDairyViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeAddDairyViewController(navigationModel: AddNavigationModel) -> AddDairyViewController {
        let assembler = Assembler(commonAssemblies + [AddDairyAssembly()])
        let viewController = AddDairyViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddDairyViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: - Relax
    static func makeRelaxViewController() -> RelaxViewController {
        let assembler = Assembler(commonAssemblies + [RelaxAssembly()])
        let viewController = RelaxViewController()
        viewController.viewModel = assembler.resolver.resolve(IRelaxViewModel.self)
        return viewController
    }

    static func makeAddRelaxViewController(navigationModel: AddNavigationModel) -> AddRelaxViewController {
        let assembler = Assembler(commonAssemblies + [AddRelaxAssembly()])
        let viewController = AddRelaxViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddRelaxViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditRelaxViewController(navigationModel: RelaxNavigationModel) -> EditRelaxViewController {
        let assembler = Assembler(commonAssemblies + [EditRelaxAssembly()])
        let viewController = EditRelaxViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditRelaxViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: - Resources
    static func makeResourcesViewController() -> ResourcesViewController {
        let assembler = Assembler(commonAssemblies + [ResourcesAsssembly()])
        let viewController = ResourcesViewController()
        viewController.viewModel = assembler.resolver.resolve(IResourcesViewModel.self)
        return viewController
    }

    static func makeEditResourseViewController(navigationModel: ResourceNavigationModel) -> EditResourceViewController {
        let assembler = Assembler(commonAssemblies + [EditResourceAssembly()])
        let viewController = EditResourceViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditResourcesViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: - Checklist
    static func makeChecklistViewController() -> ChecklistViewController {
        let assembler = Assembler(commonAssemblies + [ChecklistAssembly()])
        let viewController = ChecklistViewController()
        viewController.viewModel = assembler.resolver.resolve(IChecklistViewModel.self)
        return viewController
    }

    static func makeMoneyCategoryViewController(navigationModel: CheckListNavigationModel) -> MoneyCategoryViewController {
        let assembler = Assembler(commonAssemblies + [MoneyCategoryAssembly()])
        let viewController = MoneyCategoryViewController()
        viewController.viewModel = assembler.resolver.resolve(IMoneyCategoryViewModel.self, argument: navigationModel)
        return viewController
    }
}
