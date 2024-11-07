//
//  TabBarViewModel.swift
//
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol ITabBarViewModel {
    var appStorageService: IAppStorageService { get set }
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    func getUser()
    var user: UserModel? { get set }
}

public class TabBarViewModel: ITabBarViewModel {

    private let tabBarService: ITabBarService
    public var appStorageService: IAppStorageService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var user: UserModel?

    public init(tabBarService: ITabBarService, appStorageService: IAppStorageService) {
        self.tabBarService = tabBarService
        self.appStorageService = appStorageService
    }

    public func getUser() {
        do {
            user = try self.tabBarService.getUser()
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
