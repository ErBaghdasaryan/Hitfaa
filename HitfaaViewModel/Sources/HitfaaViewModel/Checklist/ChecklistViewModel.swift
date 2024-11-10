//
//  ChecklistViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IChecklistViewModel {
    func loadData()
    var checkLists: [ChecklistPresentationModel] { get set }
    var appStorageService: IAppStorageService { get set }
}

public class ChecklistViewModel: IChecklistViewModel {

    private let checklistService: IChecklistService
    public var checkLists: [ChecklistPresentationModel] = []
    public var appStorageService: IAppStorageService

    public init(checklistService: IChecklistService, appStorageService: IAppStorageService) {
        self.checklistService = checklistService
        self.appStorageService = appStorageService
    }

    public func loadData() {
        checkLists = checklistService.getChecklists()
    }
}
