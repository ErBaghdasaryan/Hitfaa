//
//  RelaxViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IRelaxViewModel {
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var relaxes: [RelaxModel] { get set }
    func loadData()
}

public class RelaxViewModel: IRelaxViewModel {

    private let relaxService: IRelaxService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var relaxes: [RelaxModel] = []

    public init(relaxService: IRelaxService) {
        self.relaxService = relaxService
    }

    public func loadData() {
        do {
            self.relaxes = try self.relaxService.getRelaxes()
        } catch {
            print(error)
        }
    }
}
