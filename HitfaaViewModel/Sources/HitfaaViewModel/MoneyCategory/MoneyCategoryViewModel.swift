//
//  MoneyCategoryViewModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel

public protocol IMoneyCategoryViewModel {
    var checkList: ChecklistPresentationModel { get set }
    var appStorageService: IAppStorageService { get set }
}

public class MoneyCategoryViewModel: IMoneyCategoryViewModel {

    private let checklistService: IChecklistService
    public var checkList: ChecklistPresentationModel
    public var appStorageService: IAppStorageService

    public init(checklistService: IChecklistService, appStorageService: IAppStorageService, navigationModel: CheckListNavigationModel) {
        self.checklistService = checklistService
        self.appStorageService = appStorageService
        self.checkList = navigationModel.model
    }
}
