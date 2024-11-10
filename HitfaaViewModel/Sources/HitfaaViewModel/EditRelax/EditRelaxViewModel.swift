//
//  EditRelaxViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IEditRelaxViewModel {
    func editRelax(model: RelaxModel)
    var relax: RelaxModel { get set }
}

public class EditRelaxViewModel: IEditRelaxViewModel {
    
    private let relaxService: IRelaxService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var relax: RelaxModel
    
    public init(relaxService: IRelaxService, navigationModel: RelaxNavigationModel) {
        self.relaxService = relaxService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.relax = navigationModel.model
    }
    
    public func editRelax(model: RelaxModel) {
        do {
            try self.relaxService.editRelax(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
