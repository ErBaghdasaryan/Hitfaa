//
//  ProfileViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IProfileViewModel {
    func addUser(model: UserModel)
    func updateUser(model: UserModel)
    func getUser()
    var user: UserModel? { get set }
}

public class ProfileViewModel: IProfileViewModel {

    private let profileService: IProfileService
    public var user: UserModel?

    public init(profileService: IProfileService) {
        self.profileService = profileService
    }

    public func addUser(model: UserModel) {
        do {
            _ = try self.profileService.addUser(model)
        } catch {
            print(error)
        }
    }

    public func getUser() {
        do {
            user = try self.profileService.getUser()
        } catch {
            print(error)
        }
    }

    public func updateUser(model: UserModel) {
        do {
            _ = try self.profileService.updateUser(model)
        } catch {
            print(error)
        }
    }
}
