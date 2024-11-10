//
//  AddRelaxViewModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IAddRelaxViewModel {
    func addRelax(model: RelaxModel)
}

public class AddRelaxViewModel: IAddRelaxViewModel {

    private let relaxService: IRelaxService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(relaxService: IRelaxService, navigationModel: AddNavigationModel) {
        self.relaxService = relaxService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addRelax(model: RelaxModel) {
        do {
            _ = try self.relaxService.addRelax(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
